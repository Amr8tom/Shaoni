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
        fontFamily: 'Poppins'

    ),
    headlineMedium: TextStyle(

        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: ColorRes.black,
        // height: 1.2,
        fontFamily: 'Poppins'
    ),
    headlineSmall: TextStyle().copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: ColorRes.black,
        // height: 1.2,
        fontFamily: 'Poppins'),
    titleLarge: TextStyle().copyWith(
      fontFamily: 'Poppins',
      fontSize: 28.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleMedium: TextStyle().copyWith(
        fontFamily: 'Poppins',
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black),
    titleSmall: TextStyle().copyWith(
        fontFamily: 'Poppins',
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black),
    bodyLarge: TextStyle(overflow: TextOverflow.ellipsis).copyWith(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        // height: 1.5.h,
        color: ColorRes.black
    ),
    bodyMedium: TextStyle(overflow: TextOverflow.ellipsis).copyWith(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        // height: 1.4.h,
        color: ColorRes.primary),
    bodySmall: TextStyle().copyWith(
        fontFamily: 'Poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        // height: 1.3.h,
        color: ColorRes.primary),
    labelLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 44.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black),
    labelMedium: TextStyle().copyWith(
        fontFamily: 'Poppins',
        fontSize: 35.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    // button: TextStyle(fontSize: 45.sp),
    headlineLarge: TextStyle().copyWith(
        fontSize: 32.sp, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle().copyWith(
        fontSize: 24.sp, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: TextStyle().copyWith(
        fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white),
    titleLarge: TextStyle().copyWith(
        fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: TextStyle().copyWith(
        fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: TextStyle().copyWith(
        fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.white),
    bodyLarge: TextStyle(overflow: TextOverflow.ellipsis).copyWith(
        fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
    bodyMedium: TextStyle(overflow: TextOverflow.clip).copyWith(
        fontSize: 14.sp, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: TextStyle().copyWith(
        fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
    labelLarge: TextStyle().copyWith(
        fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium: TextStyle().copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white.withOpacity(0.5)),
  );
}
