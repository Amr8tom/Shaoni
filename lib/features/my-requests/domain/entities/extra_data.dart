
import 'package:equatable/equatable.dart';
import 'package:shaoni/features/my-requests/domain/entities/car_permission/car_permission.dart';
import 'package:shaoni/features/my-requests/domain/entities/complaint_request/complaint_request_details.dart';

import '../../../human_resoures/domain/entity/exit_permisstion.dart';
import '../../data/models/attendance_request_details_model.dart';

class ExtraData extends Equatable {
  final AttendanceRequestDetailsModel? attendance;
  final String? study;
  final String? outsideWorking;
  final String? visaRequest;
  final ExitPermission? exitPermission;
  final CarPermission? carPermission;
  final ComplaintRequestDetails? complaintRequest;

  const ExtraData({
    this.carPermission,
    this.attendance,
    this.study,
    this.outsideWorking,
    this.visaRequest,
    this.exitPermission,
    this.complaintRequest,
  });

  /// fromJson
  factory ExtraData.fromJson(Map<String, dynamic> json) {
    return ExtraData(
      attendance: json['attendance'] != null
          ? AttendanceRequestDetailsModel.fromJson(json['attendance'])
          : null,
      study: json['study'],
      outsideWorking: json['outsideWorking'],
      visaRequest: json['visaRequest'],
      carPermission: json['carPermission'] != null
          ? CarPermission.fromJson(json['carPermission'])
          : null,
      exitPermission: json['exitPermission'] != null
          ? ExitPermission.fromJson(json['exitPermission'])
          : null,
      complaintRequest: json['complaintRequest'] != null
          ? ComplaintRequestDetails.fromJson(json['complaintRequest'])
          : null,
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'attendance': attendance?.toJson(),
      'study': study,
      'outsideWorking': outsideWorking,
      'visaRequest': visaRequest,
      'exitPermission': exitPermission?.toJson(),
      'carPermission': carPermission?.toJson(),
      'complaintRequest': complaintRequest?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        attendance,
        carPermission,
        complaintRequest,
        study,
        outsideWorking,
        visaRequest,
        exitPermission,
      ];
}
