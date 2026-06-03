import 'package:equatable/equatable.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/study_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/start_work_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/experience_certificate_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/id_document_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/medical_insurance_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/training_request_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/product_order_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/car_permission/car_permission.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/complaint_request/complaint_request_details.dart';

import '../../../human_resources/domain/entity/exit_permisstion.dart';
import '../../data/models/attendance_request_details_model.dart';

class ExtraData extends Equatable {
  final AttendanceRequestDetailsModel? attendance;
  final StudyModel? study;
  final StartWorkModel? startWork;
  final ExperienceCertificateModel? experienceCertificate;
  final IDDocumentModel? idDocument;
  final MedicalInsuranceModel? medicalInsurance;
  final TrainingRequestModel? trainingRequest;
  final ProductOrderModel? productOrder;
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
    this.idDocument,
    this.medicalInsurance,
    this.trainingRequest,
    this.productOrder,
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
      startWork: json['startWorking'] != null
          ? StartWorkModel.fromJson(json['startWorking'])
          : null,
      experienceCertificate: json['experienceCertificate'] != null
          ? ExperienceCertificateModel.fromJson(json['experienceCertificate'])
          : null,
      idDocument: json['idDocument'] != null
          ? IDDocumentModel.fromJson(json['idDocument'])
          : null,
      medicalInsurance: json['medicalInsurance'] != null
          ? MedicalInsuranceModel.fromJson(json['medicalInsurance'])
          : null,
      trainingRequest: json['trainingRequest'] != null
          ? TrainingRequestModel.fromJson(json['trainingRequest'])
          : null,
      productOrder: json['productOrder'] != null
          ? ProductOrderModel.fromJson(json['productOrder'])
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
      'idDocument': idDocument?.toJson(),
      'medicalInsurance': medicalInsurance?.toJson(),
      'trainingRequest': trainingRequest?.toJson(),
      'productOrder': productOrder?.toJson(),
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
        idDocument,
        medicalInsurance,
        trainingRequest,
        productOrder,
        outsideWorking,
        visaRequest,
        exitPermission,
      ];
}
