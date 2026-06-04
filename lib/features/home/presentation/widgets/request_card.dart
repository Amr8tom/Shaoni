import 'package:flutter/material.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/current_status.dart';
import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import 'home_status_badge.dart';
import 'order_text_card.dart';

class RequestCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String orderNumber;
  final String? applicantName;
  final String date;
  final String? type;
  final String? serviceCode;
  final CurrentStatus? currentStatus;
  final VoidCallback? onTap;

  const RequestCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.orderNumber,
    required this.date,
    this.type,
    this.serviceCode,
    this.currentStatus,
    this.onTap,
    this.applicantName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding * 0.85),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          boxShadow: [
            BoxShadow(
              color: ColorRes.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ── Top row: order number + date ──────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderTextCard(
                        title: S.current.orderNumber,
                        result: orderNumber.length >= 9
                            ? orderNumber.substring(9)
                            : orderNumber,
                      ),
                      const Sizer(height: 8),
                      OrderTextCard(
                        title: S.current.orderType,
                        result: type ?? '',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderTextCard(
                        title: S.current.orderDate,
                        result: date,
                      ),
                      const Sizer(height: 10),
                      HomeStatusBadge(
                        statusColor: statusColor,
                        status: status,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// ── Manager section: applicant name ───────────────────────────
            if (applicantName != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.padding * 0.6),
                child: Divider(
                  color: ColorRes.grey4,
                  height: 1,
                  thickness: 1,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: ColorRes.primary.withValues(alpha: 0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      color: ColorRes.primary,
                      size: 17,
                    ),
                  ),
                  const Sizer(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.applicantName,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorRes.grey2,
                                    fontSize: 10,
                                  ),
                        ),
                        const Sizer(height: 1),
                        Text(
                          applicantName!,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
