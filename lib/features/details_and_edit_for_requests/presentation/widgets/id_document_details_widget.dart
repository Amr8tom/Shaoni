import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../controller/my_requests_cubit.dart';

class IDDocumentDetailsWidget extends StatelessWidget {
  const IDDocumentDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final doc = controller.state.requestDetails?.extraData?.idDocument;

    return Skeletonizer(
      enabled: controller.state.status.isLoading,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
        child: Container(
          padding: EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorRes.greyForBorders),
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Section header
              Text(
                S.current.orderDetails,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),

              /// Request type
              if ((doc?.requestType?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.requestType,
                  result: doc?.requestType ?? '',
                ),
                const Sizer(height: 12),
              ],

              /// Document type
              if ((doc?.documentType?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.documentType,
                  result: doc?.documentType ?? '',
                ),
                const Sizer(height: 12),
              ],

              /// Date
              if ((doc?.date?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.startDate,
                  result: _formatDate(doc?.date),
                ),
                const Sizer(height: 12),
              ],

              /// Issuing country
              if ((doc?.issuingCountry?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.issuingCountry,
                  result: doc?.issuingCountry ?? '',
                ),
                const Sizer(height: 12),
              ],

              /// Document number
              if ((doc?.documentNumber?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.documentNumber,
                  result: doc?.documentNumber ?? '',
                ),
                const Sizer(height: 12),
              ],

              /// Issue number
              if ((doc?.issueNumber?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.issueNumber,
                  result: doc?.issueNumber ?? '',
                ),
                const Sizer(height: 12),
              ],

              /// Issue date
              if ((doc?.issueDate?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.issueDate,
                  result: _formatDate(doc?.issueDate),
                ),
                const Sizer(height: 12),
              ],

              /// End date
              if ((doc?.endDate?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.endDate,
                  result: _formatDate(doc?.endDate),
                ),
                const Sizer(height: 12),
              ],

              /// Passport number
              if ((doc?.passportNumber?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.passportNumber,
                  result: doc?.passportNumber ?? '',
                ),
                const Sizer(height: 12),
              ],

              /// Passport address
              if ((doc?.passportAddress?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.passportAddress,
                  value: doc!.passportAddress!,
                ),
                const Sizer(height: 12),
              ],

              /// Family card number
              if ((doc?.familyCardNumber?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.familyCardNumber,
                  result: doc?.familyCardNumber ?? '',
                ),
                const Sizer(height: 12),
              ],

              /// Driving license number
              if ((doc?.drivingLicenseNumber?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.drivingLicenseNumber,
                  result: doc?.drivingLicenseNumber ?? '',
                ),
                const Sizer(height: 12),
              ],

              /// Kafeel name
              if ((doc?.kafeelName?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.kafeelName,
                  result: doc?.kafeelName ?? '',
                ),
                const Sizer(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    return iso.length >= 10 ? iso.substring(0, 10) : iso;
  }
}

class _FullWidthTextBlock extends StatelessWidget {
  const _FullWidthTextBlock({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ColorRes.grey2,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Sizer(height: 6),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSizes.padding * 0.75),
          decoration: BoxDecoration(
            color: ColorRes.grey6,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
            border: Border.all(color: ColorRes.grey5),
          ),
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
