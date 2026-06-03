import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class DTextFormFieldTheme {
  DTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: ColorRes.black,
    suffixIconColor: ColorRes.black,
    labelStyle: const TextStyle().copyWith(
        fontWeight: FontWeight.w400, fontSize: 14.sp, color: ColorRes.grey),
    hintStyle: const TextStyle().copyWith(
        fontWeight: FontWeight.w400, fontSize: 14.sp, color: ColorRes.black),
    errorStyle: const TextStyle()
        .copyWith(fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: ColorRes.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1.w, color: ColorRes.black),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1.w, color: ColorRes.black),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1.w, color: ColorRes.black),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1.w, color: ColorRes.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1.w, color: ColorRes.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: ColorRes.grey,
    suffixIconColor: ColorRes.grey,
    labelStyle:
        const TextStyle().copyWith(fontSize: 14.sp, color: ColorRes.white),
    hintStyle: const TextStyle().copyWith(fontSize: 14.sp, color: ColorRes.white),
    floatingLabelStyle:
        const TextStyle().copyWith(color: ColorRes.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1.w, color: ColorRes.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1.w, color: ColorRes.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1.w, color: ColorRes.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 1.w, color: ColorRes.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(width: 2.w, color: ColorRes.warning),
    ),
  );
}
