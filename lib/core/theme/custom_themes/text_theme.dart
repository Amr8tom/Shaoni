import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class DTextTheme {
  DTextTheme._();

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle().copyWith(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: ColorRes.black,
        // height: 1.2,
        fontFamily: 'Cairo'),
    headlineMedium: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: ColorRes.black,
        // height: 1.2,
        fontFamily: 'Cairo'),
    headlineSmall: TextStyle().copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: ColorRes.black,
        // height: 1.2,
        fontFamily: 'Cairo'),
    titleLarge: TextStyle().copyWith(
      fontFamily: 'Cairo',
      fontSize: 28.sp,
      fontWeight: FontWeight.w600,
      color: ColorRes.black,
    ),
    titleMedium: TextStyle().copyWith(
        fontFamily: 'Cairo',
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: ColorRes.black),
    titleSmall: TextStyle().copyWith(
        fontFamily: 'Cairo',
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: ColorRes.black),
    bodyLarge: TextStyle(overflow: TextOverflow.ellipsis).copyWith(
        fontFamily: 'Cairo',
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        // height: 1.5.h,
        color: ColorRes.black),
    bodyMedium: TextStyle(overflow: TextOverflow.ellipsis).copyWith(
        fontFamily: 'Cairo',
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        // height: 1.4.h,
        color: ColorRes.black),
    bodySmall: TextStyle().copyWith(
        fontFamily: 'Cairo',
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        // height: 1.3.h,
        color: ColorRes.black),
    labelLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 44.sp,
        fontWeight: FontWeight.normal,
        color: ColorRes.black),
    labelMedium: TextStyle().copyWith(
        fontFamily: 'Cairo',
        fontSize: 35.sp,
        fontWeight: FontWeight.normal,
        color: ColorRes.black),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    // button: TextStyle(fontSize: 45.sp),
    headlineLarge: TextStyle().copyWith(
        fontSize: 32.sp, fontWeight: FontWeight.bold, color: ColorRes.white),
    headlineMedium: TextStyle().copyWith(
        fontSize: 24.sp, fontWeight: FontWeight.w600, color: ColorRes.white),
    headlineSmall: TextStyle().copyWith(
        fontSize: 18.sp, fontWeight: FontWeight.w600, color: ColorRes.white),
    titleLarge: TextStyle().copyWith(
        fontSize: 16.sp, fontWeight: FontWeight.w600, color: ColorRes.white),
    titleMedium: TextStyle().copyWith(
        fontSize: 16.sp, fontWeight: FontWeight.w500, color: ColorRes.white),
    titleSmall: TextStyle().copyWith(
        fontSize: 16.sp, fontWeight: FontWeight.w400, color: ColorRes.white),
    bodyLarge: TextStyle(overflow: TextOverflow.ellipsis).copyWith(
        fontSize: 14.sp, fontWeight: FontWeight.w500, color: ColorRes.white),
    bodyMedium: TextStyle(overflow: TextOverflow.clip).copyWith(
        fontSize: 14.sp, fontWeight: FontWeight.normal, color: ColorRes.white),
    bodySmall: TextStyle().copyWith(
        fontSize: 14.sp, fontWeight: FontWeight.w500, color: ColorRes.white),
    labelLarge: TextStyle().copyWith(
        fontSize: 12.sp, fontWeight: FontWeight.normal, color: ColorRes.white),
    labelMedium: TextStyle().copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: ColorRes.white.withOpacity(0.5)),
  );
}
