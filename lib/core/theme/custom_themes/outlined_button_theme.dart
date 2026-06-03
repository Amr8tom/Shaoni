import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class DOutlinedButtonTheme {
  DOutlinedButtonTheme._();

  /// Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ColorRes.black,
      side: const BorderSide(color: ColorRes.primary),
      textStyle: TextStyle(
          fontSize: 16, color: ColorRes.black, fontWeight: FontWeight.w600),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  /// Dark Theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ColorRes.white,
      side: const BorderSide(color: ColorRes.primary),
      textStyle: TextStyle(
          fontSize: 16, color: ColorRes.white, fontWeight: FontWeight.w600),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
