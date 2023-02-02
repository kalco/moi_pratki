// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

const defaultRadius = 12.0;
const defaultPadding = 15.0;
const blueColor = Color(0xff1ab1dc);
const redColor = Color(0xfff1323a);
const greenColor = Color(0xff3ad5b6);
const primaryColor = Color(0xffffcd00);
const dividerColor = Color(0xffc1c1c1);

const aqua = LinearGradient(
  colors: [Color(0xFF45B649), Color(0xFFD6DE3E)],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

const alive = LinearGradient(
  colors: [Color(0xFFBD3F32), Color(0xFFCB356B)],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

ColorThemes(BuildContext context) {
  Theme.of(context);
}

TextThemes(BuildContext context) {
  Theme.of(context).textTheme;
}

Size displaySize(BuildContext context) {
  debugPrint('Size = ${MediaQuery.of(context).size}');
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ${displaySize(context).height}');
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ${displaySize(context).width}');
  return displaySize(context).width;
}

class ConstanceData {
  static String bseImageUrl = 'assets/images/';
  static String splashLogo = "${bseImageUrl}splash_logo.png";
  static String splashBg = "${bseImageUrl}splash_bg.png";
}

int colorsIndex = 0;

var primaryColorString = '#ffcd00'; //жолта
var secondaryColorString = '#0ab7e4';
