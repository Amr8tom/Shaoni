import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../common/widgets/sizeboxs/Sizer.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/asset_resoures.dart';
import '../core/constants/colors.dart';
import '../generated/l10n.dart';

class CustomUI {
  static loader({required BuildContext context}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: RepaintBoundary(
            child: Lottie.asset(AssetRes.loaderLottie, height: 30.h),
          ),
        );
      },
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Center(
            child: RepaintBoundary(
              child: Lottie.asset(AssetRes.loaderLottie, width: 100.w),
            ),
          ),
    );
  }

  static void showFailureDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (_) => AlertDialog(
            title: Text(S.current.error),
            content: Text(message ?? S.current.error),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(S.current.done),
              ),
            ],
          ),
    );
  }

  static Widget simpleLoader() {
    return Center(
      child: RepaintBoundary(
        child: Lottie.asset(AssetRes.loaderLottie, width: 100.w),
      ),
    );
  }

  static Widget downloadingQuran() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSizes.padding * 2),
        padding: EdgeInsets.all(AppSizes.padding * 2),
        decoration: BoxDecoration(
          color: Color(0xFF1A1410),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xFFBD9E63),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFBD9E63).withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepaintBoundary(
              child: Lottie.asset(
                AssetRes.quranLottie,
                width: 150.w,
                fit: BoxFit.contain,
              ),
            ),
            const Sizer(height: 20),
            Text(
              S.current.downloadingQuran,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFBD9E63),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Sizer(height: 8),
            Text(
              S.current.pleaseWait,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFBD9E63).withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // static void showQuranReadyDialog(BuildContext context, {VoidCallback? onStart}) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (_) => Center(
  //       child: Container(
  //         margin: EdgeInsets.symmetric(horizontal: AppSizes.padding * 2),
  //         padding: EdgeInsets.all(AppSizes.padding * 2),
  //         decoration: BoxDecoration(
  //           color: Color(0xFF1A1410),
  //           borderRadius: BorderRadius.circular(20),
  //           border: Border.all(
  //             color: Color(0xFFBD9E63),
  //             width: 2,
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Color(0xFFBD9E63).withOpacity(0.3),
  //               blurRadius: 20,
  //               spreadRadius: 2,
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(AppSizes.padding),
  //               decoration: BoxDecoration(
  //                 color: Color(0xFFBD9E63).withOpacity(0.2),
  //                 shape: BoxShape.circle,
  //               ),
  //               child: Icon(
  //                 Icons.check_circle_rounded,
  //                 color: Color(0xFFBD9E63),
  //                 size: 60.sp,
  //               ),
  //             ),
  //             const Sizer(height: 20),
  //             Text(
  //               S.current.quranReady,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 color: Color(0xFFBD9E63),
  //                 fontSize: 20.sp,
  //                 fontWeight: FontWeight.w700,
  //               ),
  //             ),
  //             const Sizer(height: 8),
  //             Text(
  //               S.current.youCanStartNow,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 color: Color(0xFFBD9E63).withOpacity(0.8),
  //                 fontSize: 14.sp,
  //               ),
  //             ),
  //             const Sizer(height: 24),
  //             SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                   onStart?.call();
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Color(0xFFBD9E63),
  //                   foregroundColor: Color(0xFF1A1410),
  //                   padding: EdgeInsets.symmetric(vertical: 14.h),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                   elevation: 0,
  //                 ),
  //                 child: Text(
  //                   S.current.start,
  //                   style: TextStyle(
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }


  static Widget simpleSendingDataLoader() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            child: Lottie.asset(AssetRes.loaderLottie, width: 100.w),
          ),
          const Sizer(height: 8),
          Text(S.current.sending),
        ],
      ),
    );
  }

  static Widget mapLoader() {
    return RepaintBoundary(
      child: Center(child: Lottie.asset(AssetRes.kabbaLottie, width: 200.w)),
    );
  }

  static Widget simpleFailure() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            child: Lottie.asset(
              AssetRes.error404Lottie,
              height: AppSizes.productItemHeight,
            ),
          ),
          SizedBox(height: AppSizes.spaceBtwItems),
          Text(
            S.current.error,
            style: TextStyle(
              color: ColorRes.error,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  static Widget emptyData({String? message}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                ColorRes.primary.withOpacity(0.7),
                BlendMode.srcIn,
              ),
              child: Lottie.asset(
                AssetRes.noData,
                height: AppSizes.productItemHeight,
              ),
            ),
          ),
          SizedBox(height: AppSizes.spaceBtwItems),
          Text(
            message ?? S.current.noData,
            style: TextStyle(
              color: ColorRes.primary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  static Widget searchWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 100.h),
      child: RepaintBoundary(
        child: Lottie.asset(AssetRes.searchICon, width: 100.w),
      ),
    );
  }

  static Widget tryLater() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(S.current.tryLater),
          RepaintBoundary(
            child: Lottie.asset(AssetRes.error404Lottie, width: 100.w),
          ),
        ],
      ),
    );
  }

  static Widget noData() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            child: Lottie.asset(
              AssetRes.noData,
              height: AppSizes.productItemHeight,

            ),
          ),
          SizedBox(height: AppSizes.spaceBtwItems),
          Text(S.current.noData),
        ],
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  snackBarSuccess({required BuildContext context, String? message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? S.current.done),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  snackBarFailure({required BuildContext context, String? message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? S.current.error,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: ColorRes.white),
        ),
        backgroundColor: ColorRes.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
