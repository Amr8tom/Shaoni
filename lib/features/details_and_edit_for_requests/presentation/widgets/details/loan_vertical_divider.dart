import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';

class LoanVerticalDivider extends StatelessWidget {
  const LoanVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 36.h, color: ColorRes.greyForBorders);
  }
}
