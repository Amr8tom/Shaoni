import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../../domain/entities/visa_request.dart';
import '../controller/my_requests_cubit.dart';

class VisaRequestDetailsWidget extends StatelessWidget {
  const VisaRequestDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final visa = controller.state.requestDetails?.extraData?.visaRequest;

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
              Text(
                S.current.visaRequest,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),
              if ((visa?.visaTypeValue.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.visaType,
                  result: _visaTypeName(visa!.visaTypeValue),
                ),
                const Sizer(height: 12),
              ],
              if ((visa?.direction.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.visaDirection,
                  result: visa!.direction,
                ),
                const Sizer(height: 12),
              ],
              if ((visa?.dateFrom.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.startDate,
                  result: _date(visa!.dateFrom),
                ),
                const Sizer(height: 12),
              ],
              if ((visa?.dateTo.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.endDate,
                  result: _date(visa!.dateTo),
                ),
                const Sizer(height: 12),
              ],
              if ((visa?.reason.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.requestReason,
                  value: visa!.reason,
                ),
                const Sizer(height: 12),
              ],
              if ((visa?.note.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.notes,
                  value: visa!.note,
                ),
                const Sizer(height: 12),
              ],
              if ((visa?.lines.isNotEmpty ?? false)) ...[
                Text(
                  S.current.employees,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Sizer(height: 8),
                ...(visa?.lines ?? []).map((line) => _VisaLineCard(line: line)),
                const Sizer(height: 8),
              ],
              if ((visa?.editReasons?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.editReasons,
                  value: visa!.editReasons!,
                ),
                const Sizer(height: 12),
              ],
              if ((visa?.rejectReasons?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.rejectReasons,
                  value: visa!.rejectReasons!,
                ),
                const Sizer(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Maps a visa type backend code to its localized label.
  String _visaTypeName(String code) {
    switch (code) {
      case 'exit_return':
        return S.current.visaTypeExitReturn;
      case 'foreign_country':
        return S.current.visaTypeForeignCountry;
      case 'kingdom_entry':
        return S.current.visaTypeKingdomEntry;
      default:
        return code;
    }
  }

  /// Trims the time part from an ISO date string for display.
  String _date(String value) =>
      value.contains('T') ? value.split('T').first : value;
}

class _VisaLineCard extends StatelessWidget {
  const _VisaLineCard({required this.line});

  final VisaRequestLineEntity line;

  @override
  Widget build(BuildContext context) {
    String date(String value) =>
        value.contains('T') ? value.split('T').first : value;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(AppSizes.padding * 0.75),
      decoration: BoxDecoration(
        color: ColorRes.grey6,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        border: Border.all(color: ColorRes.grey5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderTextCard(
            title: S.current.employee,
            result: line.employeeId.toString(),
          ),
          const Sizer(height: 6),
          OrderTextCard(
            title: S.current.startDate,
            result: date(line.dateFrom),
          ),
          const Sizer(height: 6),
          OrderTextCard(
            title: S.current.endDate,
            result: date(line.dateTo),
          ),
        ],
      ),
    );
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
