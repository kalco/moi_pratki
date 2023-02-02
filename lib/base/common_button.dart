// ignore_for_file: unrelated_type_equality_checks, library_private_types_in_public_api, non_constant_identifier_names

library flutter_switch;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moi_pratki/base/color_data.dart';

PopupMenuItem PopupMenu(
    String menuTitle, IconData iconData, iconColor, int value) {
  return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(iconData, color: iconColor, size: 18.0),
          const SizedBox(width: 4.0),
          Text(menuTitle,
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      color: dividerColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500))),
        ],
      ));
}

class SplashIcon extends StatelessWidget {
  final double size;
  final VoidCallback? onPressed;
  final Widget icon;
  final double padding;
  final Color? color;
  final Color? iconColor;

  const SplashIcon({
    Key? key,
    this.size = 25,
    this.onPressed,
    required this.icon,
    this.padding = 0,
    this.color,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + padding,
      width: size + padding,
      child: IconButton(
        splashRadius: onPressed != null && onPressed != ""
            ? size / 2 + padding
            : size / 1.2,
        padding: EdgeInsets.zero,
        color: iconColor,
        icon: ClipOval(
          child: Material(
            color: color != null && color != "" ? color : Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(padding / 2),
              child: Center(child: icon),
            ),
          ),
        ),
        iconSize: size,
        onPressed: onPressed != null && onPressed != "" ? onPressed : () {},
      ),
    );
  }
}
