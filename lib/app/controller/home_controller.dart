// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:moi_pratki/NotificationService.dart';
import 'package:moi_pratki/app/models/tracking_model.dart';
import 'package:moi_pratki/base/color_data.dart';

class DataController extends GetxController {
  bool ActiveConnection = false;
  var isDataLoading = false.obs;
  var trackingList = RxList<TrackingModel>();
  final box = GetStorage();
  var savedlist = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    getData();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    checkUserConnection().whenComplete(() {});
  }

  @override
  void onClose() {}

  getData() async {
    if (box.read('id') != null) {
      savedlist = box.read('id');
      for (var e in savedlist) {
        List<TrackingData> data = List<TrackingData>.from(
            e.map((model) => TrackingData.fromJson(model)));
        TrackingModel model = TrackingModel(data);
        trackingList.add(model);
      }
        int sortDates( a,  b) {
     String formatDate(s) => s.data.last.dATAPERPUNIMIT.replaceRange(4, 6, s.data.last.dATAPERPUNIMIT.substring(4, 6).toLowerCase());
  DateTime parse(s) => DateFormat("dd-MMM-yy").parse(formatDate(s));
  return parse(b).compareTo(parse(a));
  }
      trackingList.sort(sortDates);
    }
  }

  saveData(TrackingModel model) {
    trackingList.add(model);
    savedlist.add(model.data);
    box.write('id', savedlist);
  }

  updateData(TrackingModel model) {
    EasyLoading.show();
    trackingList.remove(model);
    trackingList.add(model);
    savedlist.removeWhere((element) {
      if (element.last['NR_R_DERGESES'] == model.data.last.nRRDERGESES) {
        return true;
      } else {
        return false;
      }
    });
    savedlist.add(model.data);
    box.write('id', savedlist);
    EasyLoading.dismiss();
  }

  deleteData(TrackingModel m) {
    EasyLoading.show(status: 'Бришење..');
    savedlist.clear();
    box.remove('id');
    for (var element in trackingList) {
      savedlist.add(element.data);
    }
    box.write('id', savedlist);
    Get.snackbar(
      "Избришано",
      "Број на пратка ${m.data[0].nRRDERGESES} е избришана",
      snackPosition: SnackPosition.TOP,
      backgroundColor: greenColor,
    );
    EasyLoading.dismiss();
  }

  getJsonFromLUrl(String id) async {
    try {
      var response = await http.get(
          Uri.parse('https://www.posta.com.mk/api/api.php/shipment?code=$id'));
      return jsonDecode(response.body);
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('error', e.toString(),
          icon: const Icon(Icons.error, color: Colors.black),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (kDebugMode) {
          print('Connected OK');
        }
        ActiveConnection = true;
      }
    } on SocketException catch (_) {}
  }

  void updateInBackground() async {
    if (box.read('id') != null) {
      savedlist = box.read('id');
    }
    savedlist.forEach((element) async {
      var d = await getJsonFromLUrl(element.first['NR_R_DERGESES']);
      List<TrackingData> data = List<TrackingData>.from(
          d.map((model) => TrackingData.fromJson(model)));

      if (data.last.zABELESKA != element.last['ZABELESKA']) {
        savedlist.removeWhere((ele) {
          if (ele.last["NR_R_DERGESES"] == data.last.nRRDERGESES) {
            if (kDebugMode) {
              print(data.last.zABELESKA);
            }
            NotificationService notificationService = NotificationService();
            notificationService.initializeNotificatio();
            notificationService.showNotification(
               'Мои пратки', 'Промена во статус на пратка'
              //  data.first.nRRDERGESES.toString(),
              //  data.last.zABELESKA.toString()
              );
            savedlist.add(data);
            return true;
          } else {
            return false;
          }
        });
      }
    });
    box.write('id', savedlist);
  }
}
