// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shaoni/features/auth/presentation/widgets/auth_text_filed.dart';
//
// import '../../../../core/constants/app_sizes.dart';
// import '../../../../core/constants/colors.dart';
//
// /// Reusable profile field that matches the design exactly
// class ProfileField extends StatefulWidget {
//   final TextEditingController controller;
//   final IconData? trailingIcon;
//   final TextInputType? keyboardType;
//   final bool isObscure;
//
//   const ProfileField({
//     super.key,
//     required this.controller,
//     this.trailingIcon,
//     this.keyboardType,
//     this.isObscure = false,
//   });
//
//   @override
//   State<ProfileField> createState() => _ProfileFieldState();
// }
//
// class _ProfileFieldState extends State<ProfileField> {
//   bool isEditing = false;
//   bool obscure = false;
//
//   @override
//   void initState() {
//     super.initState();
//     obscure = widget.isObscure;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 56.h,
//       decoration: BoxDecoration(
//         color: ColorRes.white,
//         borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
//         border: Border.all(color: ColorRes.grey4, width: 1),
//       ),
//       child: Row(
//         children: [
//           /// Trailing icon - RIGHT side
//           if (widget.trailingIcon != null)
//             Padding(
//               padding: EdgeInsets.only(right: 16.w, left: 8.w),
//               child: Icon(
//                 widget.trailingIcon,
//                 color: ColorRes.grey2,
//                 size: 24.sp,
//               ),
//             ),
//
//           /// Expanded text field - CENTER (text aligned to end/right)
//           // AuthTextField(hint: "hint", controller: TextEditingController()),
//
//           /// Edit square icon - LEFT side
//           GestureDetector(
//             onTap: () => setState(() => isEditing = true),
//             child: Container(
//               margin: EdgeInsets.only(left: 8.w, right: 8.w),
//               padding: EdgeInsets.all(10.w),
//               decoration: BoxDecoration(
//                 color: ColorRes.grey4,
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Icon(
//                 Icons.edit_outlined,
//                 size: 20.sp,
//                 color: ColorRes.grey2,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
