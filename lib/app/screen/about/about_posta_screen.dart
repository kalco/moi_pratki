// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:moi_pratki/base/auto_size_text.dart';
import 'package:moi_pratki/base/color_data.dart';
import 'package:moi_pratki/base/common_button.dart';
import 'package:moi_pratki/base/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  RecurrenceBottomSheet RecurrenceSheet = RecurrenceBottomSheet();
  @override
  Widget build(BuildContext context) {
    var TextTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leadingWidth: MediaQuery.of(context).size.width / 2,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: SplashIcon(
          icon:
              Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          size: 28,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                  defaultPadding, 0, defaultPadding, defaultPadding),
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: aqua,
                      borderRadius: BorderRadius.circular(defaultRadius)),
                  margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const AppVersion(),
                      const SizedBox(height: defaultPadding * 1.5),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText("За апликацијата",
                                      maxFontSize: 20,
                                      minFontSize: 18,
                                      style: TextTheme.displayLarge!
                                          .copyWith(color: Colors.white)),
                                  const SizedBox(height: 5),
                                  Text(
                                      "Мои Пратки е мобилна апликација со која можете лесно и брзо да менаџирате со вашите пратки кои се испраќаат преку стандардна интернационална пошта.\n\nОваа апликација е резултат на личен предизвик со кој сакам да ја зголемам базата да домашни апликации кои ќе бидат од општо добро и отворени за користење за сите.\n\nМои Пратки користи јавно API кое припаѓа на 'А.Д. Пошта на Северна Македонија'. Сите информации и податоци припаѓаат ним. \n\nАпликацијата е целосно бесплатна и истата не собира никакви податоци од корисниците.",
                                      style: TextTheme.titleSmall!.copyWith(
                                          fontSize: 13,
                                          wordSpacing: 0.7,
                                          color: Colors.white70)),
                                  const SizedBox(height: defaultPadding * 1.5),
                                  SizedBox(
                                    width: 190,
                                    child: OutlinedButton(
                                        onPressed: () {
                                          RecurrenceSheet.recurrenceSheet(
                                              context);
                                        },
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Colors.white)),
                                        child: const Center(
                                            child: Text(
                                          "Повеќе информации",
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: alive,
                      borderRadius: BorderRadius.circular(defaultRadius)),
                  margin: const EdgeInsets.only(
                      bottom: defaultPadding, top: defaultPadding - 5),
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Roka Studio",
                              style: TextTheme.titleSmall!.copyWith(
                                  fontSize: 13, color: Colors.white70)),
                          Text("\u00a9 2023",
                              style: TextTheme.titleSmall!.copyWith(
                                  fontSize: 13, color: Colors.white70)),
                        ],
                      ),
                      const SizedBox(height: defaultPadding * 1.5),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText("За авторот",
                                      maxFontSize: 20,
                                      minFontSize: 18,
                                      style: TextTheme.displayLarge!
                                          .copyWith(color: Colors.white)),
                                  const SizedBox(height: 5),
                                  Text(
                                      "Martin Rayovski- основач на Roka Studio web & mobile app development studio",
                                      style: TextTheme.titleSmall!.copyWith(
                                          fontSize: 13,
                                          wordSpacing: 0.7,
                                          color: Colors.white70)),
                                  const SizedBox(height: defaultPadding * 1.5),
                                  SizedBox(
                                    width: 130,
                                    child: OutlinedButton(
                                        onPressed: () async {
                                          final url =
                                              Uri.parse('https://roka.mk');
                                          if (await canLaunchUrl(url)) {
                                            launchUrl(url);
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Colors.white)),
                                        child: const Center(
                                            child: Text(
                                          "Check more",
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  ),
                                ],
                              )),
                        ],
                      ),
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
}

class RecurrenceBottomSheet {
  recurrenceSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: EdgeInsets.only(
                    top: defaultPadding * 1.5,
                    right: defaultPadding,
                    left: defaultPadding,
                    bottom:
                        MediaQuery.of(context).padding.bottom + defaultPadding),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(defaultRadius))),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Контакт информации',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: defaultPadding * 1.5),
                      const ListTile(
                        leading: Icon(Icons.pin_drop),
                        title: Text(
                            'Орце Николов 46 1000 Скопје,\nР. Северна Македонија'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final url = Uri.parse('tel:+389 02 3105 105');
                          if (await canLaunchUrl(url)) {
                            launchUrl(url);
                          } else {
                            // ignore: avoid_print
                            print("Can't launch $url");
                          }
                        },
                        child: const ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('+389 02 3105 105'),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final url = Uri(
                            scheme: 'mailto',
                            path: 'info@posta.com.mk',
                          );
                          if (await canLaunchUrl(url)) {
                            launchUrl(url);
                          } else {
                            // ignore: avoid_print
                            print("Can't launch $url");
                          }
                        },
                        child: const ListTile(
                          leading: Icon(Icons.mail),
                          title: Text('info@posta.com.mk'),
                        ),
                      ),
                    ]),
              );
            },
          ),
        );
      },
    );
  }
}
