import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/generated/l10n.dart';

class UpdateRequestButton extends StatelessWidget {
  final String requestID;
  final String serviceType;

  const UpdateRequestButton({
    super.key,
    required this.requestID,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding * 1.8),
      child: GestureDetector(
        onTap: () => _onTap(context),
        child: Container(
          height: AppSizes.heightcontainer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.xxl),
            color: ColorRes.primary,
            boxShadow: [
              BoxShadow(
                color: ColorRes.primary.withOpacity(0.30),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
              Sizer(width: AppSizes.padding * 0.5),
              Text(
                S.current.updateRequest,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: ColorRes.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    switch (serviceType) {
      case 'car.permission':
        context.pushNamed(
          DRoutesName.createCarPermissionRoute,
          arguments: {'requestId': int.tryParse(requestID)},
        );
        break;

      case 'hr.exit.permission':
        context.pushNamed(
          DRoutesName.requestCreateDetails,
          arguments: {'requestId': int.tryParse(requestID)},
        );
        break;

      case 'attendance.update':
        context.pushNamed(
          DRoutesName.createAttendanceRoute,
          arguments: {
            'requestId': int.tryParse(requestID),
          },
        );
        break;

      case 'study.request':
        context.pushNamed(
          DRoutesName.createStudyRequestRoute,
          arguments: {'requestId': int.tryParse(requestID)},
        );
        break;

      case 'start.working':
        context.pushNamed(
          DRoutesName.createStartWorkRoute,
          arguments: {'requestId': int.tryParse(requestID)},
        );
        break;

      case 'experience.certificate':
        context.pushNamed(
          DRoutesName.createExperienceCertificateRoute,
          arguments: {'requestId': int.tryParse(requestID)},
        );
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.current.notImplementedYet),
            backgroundColor: ColorRes.grey2,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }
}
