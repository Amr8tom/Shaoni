import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class DChipTheme {
  DChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: ColorRes.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: ColorRes.black),
    selectedColor: ColorRes.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: ColorRes.white,
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: ColorRes.grey,
    labelStyle: const TextStyle(color: ColorRes.white),
    selectedColor: ColorRes.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: ColorRes.white,
  );
}
