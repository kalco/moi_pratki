import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moi_pratki/base/color_data.dart';

class AppTheme {
  static bool isLightTheme = true;

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      titleMedium: GoogleFonts.inter(
          textStyle: TextStyle(color: base.titleMedium!.color, fontSize: 15)),
      titleSmall: GoogleFonts.inter(
          textStyle: TextStyle(
              color: base.bodySmall!.color,
              fontSize: 15,
              fontWeight: FontWeight.w500)),
      bodyLarge: GoogleFonts.inter(
          textStyle: TextStyle(color: base.bodyLarge!.color, fontSize: 14)),
      bodyMedium: GoogleFonts.inter(
          textStyle: TextStyle(color: base.bodyMedium!.color, fontSize: 16)),
      labelLarge: GoogleFonts.inter(
          textStyle: TextStyle(
              color: base.labelLarge!.color,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      //Normale TextStyle headline1
      displayLarge: GoogleFonts.inter(
          textStyle: TextStyle(
              color: base.titleMedium!.color,
              fontSize: 15,
              fontWeight: FontWeight.w500)),
      bodySmall: GoogleFonts.inter(
          textStyle: TextStyle(color: base.bodySmall!.color, fontSize: 12)),
      headlineMedium: GoogleFonts.inter(
          textStyle:
              TextStyle(color: base.headlineMedium!.color, fontSize: 24)),
      displaySmall: GoogleFonts.inter(
          textStyle: TextStyle(
              color: base.displaySmall!.color,
              fontSize: 40,
              fontWeight: FontWeight.w600)),
      displayMedium: GoogleFonts.inter(
          textStyle: TextStyle(color: base.displayMedium!.color, fontSize: 60)),
      headlineSmall: GoogleFonts.inter(
          textStyle: TextStyle(
              color: base.headlineSmall!.color,
              fontSize: 20.5,
              fontWeight: FontWeight.w700)),
      titleLarge: GoogleFonts.inter(
          textStyle: TextStyle(
              color: base.titleLarge!.color,
              fontSize: 20,
              fontWeight: FontWeight.w500)),
      labelSmall: GoogleFonts.inter(
          textStyle: TextStyle(color: base.labelSmall!.color, fontSize: 10)),
    );
  }

  static ThemeData lightTheme() {
    Color primaryColor = HexColor(primaryColorString);
    Color secondaryColor = HexColor(secondaryColorString);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );

    final ThemeData base = ThemeData.light();
    return base.copyWith(
      appBarTheme: const AppBarTheme(color: Colors.white),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
      iconTheme: const IconThemeData(color: Color(0xff2b2b2b)),
      primaryColor: primaryColor,
      splashColor: Colors.white.withOpacity(0.1),
      hoverColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.transparent,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: const Color(0XFFf5f8fd),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      indicatorColor: primaryColor,
      disabledColor: Colors.black.withOpacity(0.1),
      colorScheme: colorScheme
          .copyWith(error: Colors.red)
          .copyWith(secondary: primaryColor)
          .copyWith(background: Colors.white),
    );
  }

  static ThemeData darkTheme() {
    Color primaryColor = HexColor(primaryColorString);
    Color secondaryColor = HexColor(secondaryColorString);
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      appBarTheme: AppBarTheme(color: Colors.grey[700]),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.black),
      iconTheme: const IconThemeData(color: Colors.white),
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.grey[900],
      scaffoldBackgroundColor: const Color(0xff121315),
      buttonTheme: ButtonThemeData(
          colorScheme: colorScheme, textTheme: ButtonTextTheme.primary),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      platform: TargetPlatform.iOS,
      disabledColor: Colors.black.withOpacity(0.4),
      colorScheme: colorScheme
          .copyWith(secondary: secondaryColor)
          .copyWith(background: const Color(0xff1c1d21)),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
}
