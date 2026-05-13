import 'package:flutter/cupertino.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';

import '../widgets/car_permission_details_widget.dart';
import '../widgets/complaint_request_details_widget.dart';
import '../widgets/exit_permission_details_widget.dart';

Widget GetRequestDetailsWidget({required String serviceCode}) {
  return serviceCode == "car.permission"
      ? const CarPermissionDetailsWidget()
      : serviceCode == "complaint.request"
          ? const ComplaintRequestDetailsWidget()
          : serviceCode == "hr.exit.permission"
              ? const ExitPermissionDetailsWidget()
              : const Sizer();
}
