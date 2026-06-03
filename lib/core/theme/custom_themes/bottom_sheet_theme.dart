import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';
import '../../constants/colors.dart';

class DBottomSheetTheme {
  DBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: ColorRes.white,
    modalBackgroundColor: ColorRes.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.productImageRadius)),
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: ColorRes.black,
    modalBackgroundColor: ColorRes.black,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.productImageRadius)),
  );
}
