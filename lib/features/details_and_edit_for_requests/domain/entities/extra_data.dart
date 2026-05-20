import 'package:equatable/equatable.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/study_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/start_work_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/experience_certificate_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/car_permission/car_permission.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/complaint_request/complaint_request_details.dart';

import '../../../human_resoures/domain/entity/exit_permisstion.dart';
import '../../data/models/attendance_request_details_model.dart';

class ExtraData extends Equatable {
  final AttendanceRequestDetailsModel? attendance;
  final StudyModel? study;
  final StartWorkModel? startWork;
  final ExperienceCertificateModel? experienceCertificate;
  final String? outsideWorking;
  final String? visaRequest;
  final ExitPermission? exitPermission;
  final CarPermission? carPermission;
  final ComplaintRequestDetails? complaintRequest;

  const ExtraData({
    this.carPermission,
    this.attendance,
    this.study,
    this.startWork,
    this.experienceCertificate,
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
      study: json['study'] != null ? StudyModel.fromJson(json['study']) : null,
      startWork: json['startWork'] != null
          ? StartWorkModel.fromJson(json['startWork'])
          : null,
      experienceCertificate: json['experienceCertificate'] != null
          ? ExperienceCertificateModel.fromJson(json['experienceCertificate'])
          : null,
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
      'startWork': startWork?.toJson(),
      'experienceCertificate': experienceCertificate?.toJson(),
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
        startWork,
        experienceCertificate,
        outsideWorking,
        visaRequest,
        exitPermission,
      ];
}
