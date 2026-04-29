import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentation/widgets/auth_text_filed.dart';
import '../controller/request_services/request_service_cubit.dart';


class ApplicantDataWidget extends StatelessWidget {
  const ApplicantDataWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = context.read<RequestServiceCubit>();
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
              controller: controller.applicantNameController,
              borderRadius: AppSizes.borderRadiusMd,
              validator:    (value) {
                if (value == null || value.isEmpty) {
                  return S.current.pleaseEndterValue;
                }
                return null;
              },
            ),

            /// organization
            AuthTextField(
              hint: S.current.organizationalUnit,
              controller:
              controller.organizationalUnitController,
              borderRadius: AppSizes.borderRadiusMd,
              validator:    (value) {
                if (value == null || value.isEmpty) {
                  return S.current.pleaseEndterValue;
                }
                return null;
              },
            ),

            /// location
            AuthTextField(
              hint: S.current.location,
              controller: controller.locationController,
              borderRadius: AppSizes.borderRadiusMd,
              validator:    (value) {
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
