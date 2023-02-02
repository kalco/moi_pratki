// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moi_pratki/app/controller/home_controller.dart';
import 'package:moi_pratki/app/models/tracking_model.dart';
import 'package:moi_pratki/base/color_data.dart';
import 'package:moi_pratki/base/common_button.dart';
import 'package:moi_pratki/base/constant.dart';
import 'package:moi_pratki/base/translate.dart';
import 'package:moi_pratki/base/widgets.dart';

class HomeManage extends StatefulWidget {
  const HomeManage({Key? key}) : super(key: key);

  @override
  _HomeManageState createState() => _HomeManageState();
}

class _HomeManageState extends State<HomeManage> with TickerProviderStateMixin {
  TrackingBottomSheet trackingSheet = TrackingBottomSheet();
  DataController dataController = Get.put(DataController());
  final TextEditingController _controller = TextEditingController();
  bool isSearching = false;
  TrackingModel? trackingModel;
  String isSelected = "";
  late int defaultChoiceIndex;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        setState(() {
          isSearching = true;
        });
      }
    });
    defaultChoiceIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    var ColorTheme = Theme.of(context);
    var TextTheme = Theme.of(context).textTheme;
    var MediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                defaultPadding,
                MediaQuery.of(context).padding.top + defaultPadding,
                defaultPadding,
                0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Мои пратки",
                        style: TextTheme.displayLarge!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    const AppBarIcons(),
                  ],
                ),
                Row(
                  children: [
                    Text("овозможено од posta.com.mk",
                        style: TextTheme.displayLarge!.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w400)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: defaultPadding, bottom: defaultPadding * 1.5),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).disabledColor,
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: const Offset(0.0, 2.0)),
                    ],
                  ),
                  child: TextField(
                      controller: _controller,
                      maxLength: 20,
                      textCapitalization: TextCapitalization.characters,
                      onChanged: _onChanged(_controller.text),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) async {
                        if (_controller.text.isNotEmpty) {
                          EasyLoading.show();
                          trackingModel = null;
                          var d = await dataController
                              .getJsonFromLUrl(_controller.text);
                          List<TrackingData> data = List<TrackingData>.from(
                              d.map((model) => TrackingData.fromJson(model)));
                          if (data.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Не се пронајдени податоци'),
                                    behavior: SnackBarBehavior.floating));
                            EasyLoading.dismiss();
                          } else {
                            setState(() {
                              trackingModel = TrackingModel(data);
                              if (kDebugMode) {
                                print(trackingModel);
                              }
                            });
                            EasyLoading.dismiss();
                          }
                        } else {
                          Get.snackbar(
                            "Грешка",
                            "Внесете број на пратка",
                            colorText: Colors.white,
                            icon: const Icon(Icons.error, color: Colors.white),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: redColor,
                          );
                        }
                      },
                      textAlignVertical: TextAlignVertical.center,
                      style: Theme.of(context).textTheme.displayLarge,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          counterText: "",
                          fillColor: AppTheme.isLightTheme
                              ? Theme.of(context).colorScheme.background
                              : Colors.black,
                          hintText: "Внесете број на пратка...",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 13),
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 16),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search, size: 26),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius - 5),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius - 5),
                              borderSide: BorderSide(
                                  color: AppTheme.isLightTheme
                                      ? Theme.of(context).colorScheme.background
                                      : Theme.of(context).dividerColor,
                                  width: 1)))),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding,
                  MediaQuery.of(context).padding.bottom + defaultPadding * 2.5),
              children: [
                isSearching
                    ? Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: ColorTheme.colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                                color: ColorTheme.disabledColor,
                                blurRadius: 15,
                                spreadRadius: 2),
                          ],
                        ),
                        child: trackingModel != null
                            ? _buildSearchList(trackingModel!)
                            : Container())
                    : SizedBox(
                        width: MediaQueryWidth,
                        child: dataController.trackingList.isNotEmpty
                            ? Obx(
                                () => Column(
                                  children: List.generate(
                                    dataController.trackingList.length,
                                    (index) {
                                      return _buildList(
                                          dataController.trackingList[index]);
                                    },
                                  ),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                8),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10),
                                  Text("Немате зачувани пратки",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 25)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              40),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                20),
                                    child: Text(
                                      "Користете го полето за пребарување за да ги следите вашите пратки",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20 *
                                              3),
                                ],
                              ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Lista na zacuvani pratki na pocetna strana

  Widget _buildList(TrackingModel model) {
    var ColorTheme = Theme.of(context);
    var TextTheme = Theme.of(context).textTheme;
    bool s = false;
    for (var element in model.data) {
      if (s != true && element.zABELESKA == 'Ispora~ana') {
        s = true;
      }
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());

        trackingSheet.trackingSheet(context, model);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: defaultPadding),
        child: Container(
          decoration: BoxDecoration(
              color: ColorTheme.colorScheme.background,
              border: Border(
                  left:
                      BorderSide(color: s ? greenColor : redColor, width: 3.0)),
              boxShadow: [
                BoxShadow(
                    color: ColorTheme.disabledColor,
                    blurRadius: 15,
                    spreadRadius: 2),
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(defaultPadding * 1.2, defaultPadding, defaultPadding * 0.2, defaultPadding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                model.data[0].naslov != ''
                                    ? model.data[0].naslov.toString()
                                    : 'Пратка без наслов',
                                style: TextTheme.headlineSmall!
                                    .copyWith(fontSize: 16)),
                            Text(model.data[0].nRRDERGESES.toString(),
                                style: TextTheme.titleSmall!
                                    .copyWith(fontSize: 13)),
                          ],
                        ),
                        const Spacer(),
                        PopupMenuButton(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(defaultRadius)),
                            color: ColorTheme.colorScheme.background,
                            icon: const Icon(Icons.more_vert_outlined,
                                color: dividerColor),
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenu('Промени забелешка', Icons.edit,
                                    dividerColor, 1),
                                PopupMenu('Копирај', Icons.content_copy,
                                    dividerColor, 2),
                                PopupMenu('Избриши', Icons.delete_outline,
                                    dividerColor, 3),
                              ];
                            },
                            onSelected: (id) async {
                              if (id == 1) {
                                _updateNoticeDialog(context,
                                    model); // Perform action on click on share
                              }
                              if (id == 2) {
                                await Clipboard.setData(ClipboardData(
                                        text: model.data[0].nRRDERGESES))
                                    .then((value) => ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Бројот на пратката е копиран!'))));
                              }

                              if (id == 3) {
                                setState(() {
                                  dataController.trackingList.remove(model);
                                  dataController.deleteData(model);
                                });
                              }
                            }),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        const SizedBox(width: defaultPadding - 8),
                        RichText(
                          text: TextSpan(
                            text: TranslatorHelper.transliterateToCyrillic(model
                                .data[model.data.length - 1].zABELESKA
                                .toString()),
                            style:
                                TextTheme.headlineSmall!.copyWith(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(
                          defaultPadding, 8, defaultPadding, defaultPadding),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            TranslatorHelper.transliterateToCyrillic(model
                                .data[model.data.length - 1].dATAPERPUNIMIT
                                .toString()),
                            style:
                                TextTheme.titleSmall!.copyWith(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Pratka koja ke se prikaze posle prebaruvanje, a pred da se zacuva. Odkako ke se zacuva se prikazuva vo _buildList

  Widget _buildSearchList(TrackingModel model) {
    var ColorTheme = Theme.of(context);
    var TextTheme = Theme.of(context).textTheme;
    int sortDates(a, b) {
      String formatDate(s) => s.dATAPERPUNIMIT
          .replaceRange(4, 6, s.dATAPERPUNIMIT.substring(4, 6).toLowerCase());
      DateTime parse(s) => DateFormat("dd-MMM-yy").parse(formatDate(s));
      return parse(a).compareTo(parse(b));
    }

    model.data.sort(sortDates);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(model.data[0].nRRDERGESES ?? 'no data',
                style: TextTheme.headlineSmall),
            SizedBox(
              height: 30,
              child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      EasyLoading.show(status: 'Зачувува...');
                      bool isExist = false;
                      for (var element in dataController.trackingList) {
                        if (element.data[0].nRRDERGESES ==
                            model.data[0].nRRDERGESES) {
                          Get.snackbar(
                            "Грешка",
                            "Пратката ${model.data[0].nRRDERGESES} е веќе зачувана",
                            colorText: Colors.white,
                            icon: const Icon(Icons.error, color: Colors.white),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: redColor,
                          );
                          isExist = true;
                          _controller.clear();
                          EasyLoading.dismiss();
                          trackingModel = null;
                        }
                      }
                      if (!isExist) {
                        _addNoticeDialog(context, model);
                        _controller.clear();
                        trackingModel = null;
                        isSearching = false;
                        EasyLoading.dismiss();
                      }
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          ColorTheme.colorScheme.background)),
                  child: Text("Зачувајте",
                      style: TextTheme.headlineSmall!
                          .copyWith(color: blueColor, fontSize: 12))),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding - 5),
        Column(
            children: model.data
                .map((p) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: defaultPadding),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Од: ${p.pOSTAFILLIM}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextTheme.headlineSmall!
                                          .copyWith(fontSize: 13)),
                                  const SizedBox(height: 5),
                                  Text(
                                      TranslatorHelper.transliterateToCyrillic(
                                          p.zABELESKA.toString()),
                                      style: TextTheme.titleSmall!.copyWith(
                                          fontSize: 14, color: greenColor)),
                                ],
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("До: ${p.pOSTAFUND}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextTheme.headlineSmall!
                                          .copyWith(fontSize: 13)),
                                  const SizedBox(height: 5),
                                  Text(
                                      TranslatorHelper.transliterateToCyrillic(
                                          p.dATAPERPUNIMIT.toString()),
                                      style: TextTheme.titleSmall!
                                          .copyWith(fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: defaultPadding)
                      ],
                    ))
                .toList()),
      ],
    );
  }

  Future<void> _addNoticeDialog(
      BuildContext context, TrackingModel model) async {
    TextEditingController _textFieldController = TextEditingController();
    var ColorTheme = Theme.of(context);
    var TextTheme = Theme.of(context).textTheme;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              textInputAction: TextInputAction.next,
              textAlignVertical: TextAlignVertical.center,
              style: TextTheme.displayLarge,
              decoration: InputDecoration(
                hintText: "Внесете забелешка",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide:
                        BorderSide(color: ColorTheme.primaryColor, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide:
                        BorderSide(color: ColorTheme.dividerColor, width: 1)),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding * 1.4),
                hintStyle: TextTheme.titleSmall!.copyWith(fontSize: 16),
              ),
              onChanged: (value) {},
              maxLength: 20,
              controller: _textFieldController,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  model.data[0].naslov = _textFieldController.text;
                  // dataController.editData(
                  //     model.data[0].nRRDERGESES, _textFieldController.text);
                  dataController.saveData(model);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Зачувај",
                  style: TextStyle(color: blueColor, fontSize: 18),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _updateNoticeDialog(
      BuildContext context, TrackingModel model) async {
    TextEditingController _textFieldController = TextEditingController();
    _textFieldController.text = model.data.first.naslov.toString();
    var ColorTheme = Theme.of(context);
    var TextTheme = Theme.of(context).textTheme;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              textInputAction: TextInputAction.next,
              textAlignVertical: TextAlignVertical.center,
              style: TextTheme.displayLarge,
              decoration: InputDecoration(
                hintText: "Внесете забелешка",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide:
                        BorderSide(color: ColorTheme.primaryColor, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide:
                        BorderSide(color: ColorTheme.dividerColor, width: 1)),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding * 1.4),
                hintStyle: TextTheme.titleSmall!.copyWith(fontSize: 16),
              ),
              onChanged: (value) {},
              maxLength: 20,
              controller: _textFieldController,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  model.data[0].naslov = _textFieldController.text;
                  dataController.updateData(model);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Зачувај",
                  style: TextStyle(color: blueColor, fontSize: 18),
                ),
              ),
            ],
          );
        });
  }

// Promeni na pocetna straka koga ke se selektira search. (se gubat zacuvanite pratki i se pokazuva prazna strana)

  _onChanged(String value) {
    setState(() {
      if (value.length < 2) {
        isSearching = false;
      } else {
        isSearching = true;
      }
    });
  }

//  Izvestuvanje koga ke se promeni status na pratka

  void onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => const HomeManage()),
    );
  }
}

// Celosen prkaz na pratkak so site informacii

class TrackingBottomSheet {
  trackingSheet(BuildContext context, TrackingModel model) {
    var TextTheme = Theme.of(context).textTheme;
    int sortDates(a, b) {
      String formatDate(s) => s.dATAPERPUNIMIT
          .replaceRange(4, 6, s.dATAPERPUNIMIT.substring(4, 6).toLowerCase());
      DateTime parse(s) => DateFormat("dd-MMM-yy").parse(formatDate(s));
      return parse(a).compareTo(parse(b));
    }
 model.data.sort(sortDates);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.2,
                maxChildSize: 0.95,
                builder: (_, controller) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        padding: const EdgeInsets.only(
                            top: defaultPadding * 1.5,
                            right: defaultPadding,
                            left: defaultPadding),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(defaultRadius),
                            topRight: Radius.circular(defaultRadius),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                controller: controller,
                                padding: EdgeInsets.fromLTRB(0, 5, 0,
                                    MediaQuery.of(context).padding.bottom),
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(model.data[0].naslov != ''
                                        ?  "Следење на пратка ${model.data[0].naslov.toString()}"
                                        : "Следење на пратка ${model.data[0].nRRDERGESES.toString()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(fontSize: 13)),
                                      const SizedBox(height: defaultPadding),
                                      Column(
                                        children: model.data
                                            .map(
                                              (p) => Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Од: ${p.pOSTAFILLIM}',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        p.pOSTAFUND != null
                                                            ? 'До: ${p.pOSTAFUND}'
                                                            : ' ',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                Get.width / 1.6,
                                                            child: Text(
                                                              TranslatorHelper
                                                                  .transliterateToCyrillic(p
                                                                      .dATAPERPUNIMIT
                                                                      .toString()),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                Get.width / 1.6,
                                                            child: Text(
                                                                TranslatorHelper
                                                                    .transliterateToCyrillic(p
                                                                        .zABELESKA
                                                                        .toString()),
                                                                style: TextTheme
                                                                    .headlineSmall!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            13)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                      height:
                                                          defaultPadding * 3,
                                                      color: dividerColor,
                                                      thickness: 0.9)
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
