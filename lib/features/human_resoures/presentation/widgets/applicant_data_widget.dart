import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentation/widgets/auth_text_filed.dart';
import '../controller/exit_permission/exit_request_service_cubit.dart';

class ApplicantDataWidget extends StatelessWidget {
  const ApplicantDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = context.read<ExitRequestServiceCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.requestApplicantData,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Column(
          children: [
            /// name
            AuthTextField(
              hint: S.current.applicantName,
              // controller: controller.applicantNameController,
              controller: TextEditingController(),
              borderRadius: AppSizes.borderRadiusMd,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.current.pleaseEndterValue;
                }
                return null;
              },
            ),

            /// organization
            AuthTextField(
              hint: S.current.organizationalUnit,
              controller: TextEditingController(),
              // controller.organizationalUnitController,
              borderRadius: AppSizes.borderRadiusMd,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.current.pleaseEndterValue;
                }
                return null;
              },
            ),

            /// location
            AuthTextField(
              hint: S.current.location,
              // controller: controller.locationController,
              controller: TextEditingController(),
              borderRadius: AppSizes.borderRadiusMd,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.current.pleaseEndterValue;
                }
                return null;
              },
            ),
          ],
        ),
      ],
    );
  }
}
