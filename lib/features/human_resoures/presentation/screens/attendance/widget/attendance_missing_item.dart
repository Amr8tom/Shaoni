import 'package:flutter/material.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/routing/route_names.dart';
import '../../../controller/attendance/attendance_cubit.dart';
import '../../../widgets/attendance/attendance_record_card.dart';

class AttendanceMissingItem extends StatelessWidget {
  const AttendanceMissingItem({super.key, required this.state});

  final AttendanceState state;

  @override
  Widget build(BuildContext context) {
    final records = state.records;

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      padding: EdgeInsets.zero,
      itemCount: records.length, // +1 for header
      itemBuilder: (context, index) {
        final recordIndex = index;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.padding,
            vertical: AppSizes.padding / 2,
          ),
          child: AttendanceRecordCard(
              record: records[recordIndex],
              onTap: () {
                context.pushNamed(
                  DRoutesName.createAttendanceRoute,
                  arguments: {
                    'attendanceID': records[recordIndex].id,
                  },
                );
              }),
        );
      },
    );
  }
}
