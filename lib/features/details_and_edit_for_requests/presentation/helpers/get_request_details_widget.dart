import 'package:flutter/cupertino.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';

import '../widgets/attendance_request_details_widget.dart';
import '../widgets/car_permission_details_widget.dart';
import '../widgets/complaint_request_details_widget.dart';
import '../widgets/exit_permission_details_widget.dart';
import '../widgets/study_request_details_widget.dart';
import '../widgets/start_work_request_details_widget.dart';

Widget GetRequestDetailsWidget({required String serviceCode}) {
  switch (serviceCode) {
    case 'car.permission':
      return const CarPermissionDetailsWidget();
    case 'complaint.request':
      return const ComplaintRequestDetailsWidget();
    case 'hr.exit.permission':
      return const ExitPermissionDetailsWidget();
    case 'attendance.update':
      return const AttendanceRequestDetailsWidget();
    case 'study.request':
      return const StudyRequestDetailsWidget();
    case 'start.working':
      return const StartWorkRequestDetailsWidget();
    default:
      return const Sizer();
  }
}
