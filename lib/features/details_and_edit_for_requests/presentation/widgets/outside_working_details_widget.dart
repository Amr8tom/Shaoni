import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../../domain/entities/outside_working_details.dart';
import '../controller/my_requests_cubit.dart';

class OutsideWorkingDetailsWidget extends StatelessWidget {
  const OutsideWorkingDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final ow = controller.state.requestDetails?.extraData?.outsideWorking;

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
                S.current.outsideWorkingRequest,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),
              if (ow == null)
                Center(
                  child: Text(
                    S.current.noData,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              else ...[
                if (ow.orderReason.isNotEmpty) ...[
                  OrderTextCard(
                    title: S.current.requestJustifications,
                    result: ow.orderReason,
                  ),
                  const Sizer(height: 12),
                ],
                if (ow.departmentType.isNotEmpty) ...[
                  OrderTextCard(
                    title: S.current.departmentType,
                    result: ow.departmentType,
                  ),
                  const Sizer(height: 12),
                ],
                if (ow.projectType.isNotEmpty) ...[
                  OrderTextCard(
                    title: S.current.projectType,
                    result: ow.projectType,
                  ),
                  const Sizer(height: 12),
                ],
                if (ow.attendanceWay.isNotEmpty) ...[
                  OrderTextCard(
                    title: S.current.attendanceWay,
                    result: ow.attendanceWay,
                  ),
                  const Sizer(height: 12),
                ],
                if (ow.startDate.isNotEmpty) ...[
                  OrderTextCard(
                    title: S.current.startDate,
                    result: _date(ow.startDate),
                  ),
                  const Sizer(height: 12),
                ],
                if (ow.endDate.isNotEmpty) ...[
                  OrderTextCard(
                    title: S.current.endDate,
                    result: _date(ow.endDate),
                  ),
                  const Sizer(height: 12),
                ],
                OrderTextCard(
                  title: S.current.includeWeekend,
                  result: ow.includeWeekend ? S.current.yes : S.current.no,
                ),
                const Sizer(height: 12),
                if ((ow.editReasons?.isNotEmpty ?? false)) ...[
                  OrderTextCard(
                    title: S.current.editReasons,
                    result: ow.editReasons!,
                  ),
                  const Sizer(height: 12),
                ],
                if ((ow.rejectReasons?.isNotEmpty ?? false)) ...[
                  OrderTextCard(
                    title: S.current.rejectReasons,
                    result: ow.rejectReasons!,
                  ),
                  const Sizer(height: 12),
                ],
                if (ow.lines.isNotEmpty) ...[
                  const Sizer(height: 4),
                  Text(
                    S.current.employees,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Sizer(height: 8),
                  ...ow.lines.map((line) => _LineCard(line: line)),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _date(String value) =>
      value.contains('T') ? value.split('T').first : value;
}

class _LineCard extends StatelessWidget {
  const _LineCard({required this.line});

  final OutsideWorkingLineEntity line;

  String _plain(String html) => html.replaceAll(RegExp(r'<[^>]*>'), '').trim();

  String _date(String value) =>
      value.contains('T') ? value.split('T').first : value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(AppSizes.padding * 0.75),
      decoration: BoxDecoration(
        color: ColorRes.grey6,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        border: Border.all(color: ColorRes.grey5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (line.tasks.isNotEmpty) ...[
            OrderTextCard(title: S.current.tasks, result: line.tasks),
            const Sizer(height: 8),
          ],
          if (_plain(line.privateTasks).isNotEmpty) ...[
            OrderTextCard(
              title: S.current.privateTasks,
              result: _plain(line.privateTasks),
            ),
            const Sizer(height: 8),
          ],
          if (line.startDate.isNotEmpty)
            OrderTextCard(
              title: S.current.startDate,
              result: _date(line.startDate),
            ),
          if (line.endDate.isNotEmpty) ...[
            const Sizer(height: 8),
            OrderTextCard(
              title: S.current.endDate,
              result: _date(line.endDate),
            ),
          ],
          const Sizer(height: 8),
          OrderTextCard(
            title: S.current.exceptionRequest,
            result: line.exceptionRequest ? S.current.yes : S.current.no,
          ),
        ],
      ),
    );
  }
}
