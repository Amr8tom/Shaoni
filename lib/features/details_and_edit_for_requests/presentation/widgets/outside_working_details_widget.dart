import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resources.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../../domain/entities/outside_working_details.dart';
import '../../domain/use_cases/outside_working_line_action_use_case.dart';
import '../controller/my_requests_cubit.dart';

class OutsideWorkingDetailsWidget extends StatelessWidget {
  const OutsideWorkingDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final details = controller.state.requestDetails;
    final ow = details?.extraData?.outsideWorking;
    final requestId = details?.request?.id;

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
                    S.current.employeesDetails,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Sizer(height: 8),
                  ...ow.lines.map(
                    (line) => _LineCard(line: line, requestId: requestId),
                  ),
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
  const _LineCard({required this.line, required this.requestId});

  final OutsideWorkingLineEntity line;
  final int? requestId;

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
          if (line.odooLineId != null) ...[
            OrderTextCard(
              title: S.current.assignmentNumber,
              result: line.odooLineId.toString(),
            ),
            const Sizer(height: 8),
          ],
          if (line.state.isNotEmpty) ...[
            OrderTextCard(
              title: S.current.requestStatus,
              result: line.state,
            ),
            const Sizer(height: 8),
          ],
          if (line.startDate.isNotEmpty) ...[
            OrderTextCard(
              title: S.current.startDate,
              result: _date(line.startDate),
            ),
            const Sizer(height: 8),
          ],
          if (line.endDate.isNotEmpty) ...[
            OrderTextCard(
              title: S.current.endDate,
              result: _date(line.endDate),
            ),
            const Sizer(height: 8),
          ],
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
          if (line.attendanceWay.isNotEmpty) ...[
            OrderTextCard(
              title: S.current.attendanceWay,
              result: line.attendanceWay,
            ),
            const Sizer(height: 8),
          ],
          OrderTextCard(
            title: S.current.includeWeekend,
            result: line.includeWeekend ? S.current.yes : S.current.no,
          ),
          const Sizer(height: 8),
          OrderTextCard(
            title: S.current.exceptionRequest,
            result: line.exceptionRequest ? S.current.yes : S.current.no,
          ),
          if (line.cancelReason.isNotEmpty) ...[
            const Sizer(height: 8),
            OrderTextCard(
              title: S.current.rejectReasons,
              result: line.cancelReason,
            ),
          ],

          /// Accept / refuse — available regardless of the request stage.
          if (line.odooLineId != null) ...[
            const Sizer(height: 12),
            _LineActions(lineId: line.odooLineId!),
          ],
        ],
      ),
    );
  }
}

class _LineActions extends StatelessWidget {
  const _LineActions({required this.lineId});

  final int lineId;

  OutsideWorkingLineAction _approveAction(bool isManager) => isManager
      ? OutsideWorkingLineAction.approveManager
      : OutsideWorkingLineAction.approveEmployee;

  OutsideWorkingLineAction _disapproveAction(bool isManager) => isManager
      ? OutsideWorkingLineAction.disapproveManager
      : OutsideWorkingLineAction.disapproveEmployee;

  /// Runs the action, then confirms and sends the user back to the home tabs.
  Future<void> _run(
    BuildContext context, {
    required OutsideWorkingLineAction action,
    String cancelReason = '',
  }) async {
    final cubit = context.read<MyRequestsCubit>();

    final succeeded = await cubit.outsideWorkingLineAction(
      lineId: lineId,
      action: action,
      cancelReason: cancelReason,
    );

    if (!context.mounted) return;

    if (!succeeded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.current.error),
          backgroundColor: ColorRes.error.withValues(alpha: 0.5),
        ),
      );
      return;
    }

    void goHome() => context.pushNamedAndRemoveUntil(
          DRoutesName.navigationMenuRoute,
          predicate: (route) => false,
        );

    customDialogImgTitleDes(
      context: context,
      title: S.current.actionExecutedSuccessfully,
      des: action.isDisapprove
          ? S.current.requestRejectedSuccessfully
          : S.current.requestAcceptedSuccessfully,
      orderNumber: '',
      button1: S.current.myOrders,
      button2: S.current.home,
      onTab1: goHome,
      onTab2: goHome,
      imgPath: AssetRes.doubleCorrect,
      isSvg: true,
    );
  }

  Future<void> _refuse(BuildContext context, bool isManager) async {
    final reasonController = TextEditingController();

    final reason = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorRes.white,
        title: Text(
          S.current.rejectReasons,
          style: Theme.of(dialogContext).textTheme.bodyLarge,
        ),
        content: TextField(
          controller: reasonController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: S.current.rejectReasons,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              S.current.cancel,
              style: Theme.of(dialogContext).textTheme.labelSmall,
            ),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(reasonController.text.trim()),
            child: Text(
              S.current.confirm,
              style: Theme.of(dialogContext).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );

    reasonController.dispose();
    if (reason == null || reason.isEmpty) return;
    if (!context.mounted) return;

    await _run(
      context,
      action: _disapproveAction(isManager),
      cancelReason: reason,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isManager = context.read<MyRequestsCubit>().isManagerUser;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorRes.primary,
              foregroundColor: ColorRes.white,
            ),
            onPressed: () => _run(
              context,
              action: _approveAction(isManager),
            ),
            child: Text(isManager ? S.current.managerAccept : S.current.accept,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorRes.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const Sizer(width: 10),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorRes.error,
              side: BorderSide(color: ColorRes.error),
            ),
            onPressed: () => _refuse(context, isManager),
            child: Text(isManager ? S.current.managerReject : S.current.reject,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: ColorRes.error, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
