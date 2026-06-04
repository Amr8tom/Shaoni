import 'package:flutter/material.dart';

import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/attendance_record.dart';
import '../widget/attendance_card_header.dart';
import 'attendance_check_in_box.dart';
import '../widget/attendance_info_box.dart';

class AttendanceRecordCard extends StatelessWidget {
  const AttendanceRecordCard(
      {super.key, required this.record, required this.onTap});

  final AttendanceRecord record;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          border: Border.all(color: ColorRes.grey5, width: 1),
          boxShadow: [
            BoxShadow(
              color: ColorRes.primary.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// 1) Header banner
            AttendanceCardHeader(
              title: record.gregorianDate.substring(0, 10),
              employeeName: record.employeeName,
            ),

            /// 2) Body — check-in + checkout/outmode row
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding, vertical: AppSizes.padding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// CHECK-IN box
                  Expanded(
                    child: AttendanceCheckInBox(
                      time: record.checkInTime,
                      gregorianDate: record.gregorianDate,
                      hijriDate: record.hijriDate,
                      isCheckedIn: record.isCheckedIn,
                    ),
                  ),
                  const Sizer(width: 12),

                  /// CHECK-OUT box
                  Expanded(
                    child: AttendanceInfoBox(
                      label: S.current.checkOut,
                      value: record.isCheckedOut
                          ? (record.checkOutTime ?? '—')
                          : S.current.notAvailable,
                      detail: record.isCheckedOut
                          ? '${record.hijriDate} – ${record.checkOutTime ?? "—"}'
                          : '${record.hijriDate} – ${S.current.notAvailable}',
                      isAvailable: record.isCheckedOut,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
