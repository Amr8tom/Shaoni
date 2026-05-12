import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/custom_ui.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/routing/route_names.dart';
import '../../../domain/entity/attendance_record.dart';
import '../../controller/attendance/attendance_cubit.dart';
import 'attendance_record_card.dart';

class AttendanceMissingItem extends StatelessWidget {
  const AttendanceMissingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final records = state.isLoading
            ? List.filled(
                3,
                AttendanceRecord(
                    id: "1",
                    odooId: "2",
                    employeeId: "3",
                    employeeName: "Employee Name",
                    gregorianDate: "2024-05-07",
                    hijriDate: "27 شوال 1445",
                    checkInTime: "07:30 ص",
                    isCheckedIn: true,
                    checkOutTime: "04:15 م",
                    isCheckedOut: true,
                    outMode: null))
            : state.records ?? [];

        return state.isEmpty ?CustomUI.noData():
        Container(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: EdgeInsets.zero,

            itemCount: records.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding,
                  vertical: AppSizes.padding / 2,
                ),
                child: Skeletonizer(
                  enabled: state.isLoading,

                  child: AttendanceRecordCard(
                      record: records[index],
                      onTap: () {
                        context.pushNamed(
                          DRoutesName.createAttendanceRoute,
                          arguments: {
                            'attendanceID': records[index].id,
                          },
                        );
                      }),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
