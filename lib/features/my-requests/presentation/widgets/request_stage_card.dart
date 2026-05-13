import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/my-requests/domain/entities/current_status.dart';
import 'package:shaoni/features/my-requests/domain/enums_and_extentions/request_enums.dart';
import 'package:shaoni/features/my-requests/presentation/widgets/stage_row.dart';

import '../../../../generated/l10n.dart';

class RequestStageCard extends StatelessWidget {
  final CurrentStatus status;
  final String serviceType;

  const RequestStageCard({super.key, required this.status,required this.serviceType});

  // ─── helpers ────────────────────────────────────────────────────────────────

  String _statusName(BuildContext context) {
    final isAr = S.current.localeee != 'en';
    return isAr
        ? (status.nameAr ?? status.nameEn ?? '')
        : (status.nameEn ?? status.nameAr ?? '');
  }

  RequestStatusEnum get _enum => status.getRequestStatusEnum(serviceType: serviceType);

  int get _activeIndex {
    switch (_enum) {
      case RequestStatusEnum.newRequest:
        return 0;
      case RequestStatusEnum.managerApproval:
        return 1;
      case RequestStatusEnum.hrApproval:
        return 2;
      case RequestStatusEnum.done:
        return 3; // all complete
      case RequestStatusEnum.rejected:
        return -1; // special state
      default:
        return 0;
    }
  }

  bool get _isRejected => _enum == RequestStatusEnum.rejected;

  @override
  Widget build(BuildContext context) {
    final stages = [
      S.current.NNew,
      S.current.managerApproval,
      S.current.hrManagerApproval,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          border: Border.all(color: ColorRes.greyForBorders, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ── Header row: title + status badge ──────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.requestStage,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                _StatusBadge(
                  label: _statusName(context),
                  color: _isRejected ? ColorRes.error : ColorRes.primary,
                ),
              ],
            ),

            Divider(color: ColorRes.grey4, height: AppSizes.padding * 1.5),
            const Sizer(height: 8),

            if (_isRejected)
              _RejectedBanner()
            else
              ...List.generate(stages.length, (i) {
                final isCompleted = i < _activeIndex;
                final isActive = i == _activeIndex;
                final isPending = i > _activeIndex;
                final isLast = i == stages.length - 1;

                return StageRow(
                  index: i,
                  title: stages[i],
                  isCompleted: isCompleted,
                  isActive: isActive,
                  isPending: isPending,
                  isLast: isLast,
                  activeColor: ColorRes.primary,
                );
              }),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.35), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _RejectedBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ColorRes.error.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorRes.error.withOpacity(0.25), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.cancel_rounded, color: ColorRes.error, size: 22),
          const SizedBox(width: 10),
          Text(
            S.current.rejectedRequest,
            style: TextStyle(
              color: ColorRes.error,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
