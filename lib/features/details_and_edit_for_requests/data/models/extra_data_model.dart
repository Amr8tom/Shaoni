import 'package:shaoni/features/details_and_edit_for_requests/data/models/attendance_request_details_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/experience_certificate_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/id_document_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/medical_insurance_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/product_order_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/start_work_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/study_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/training_request_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/extra_data.dart';

class ExtraDataModel extends ExtraData {
  const ExtraDataModel({
    super.carPermission,
    super.attendance,
    super.study,
    super.startWork,
    super.experienceCertificate,
    super.idDocument,
    super.medicalInsurance,
    super.trainingRequest,
    super.productOrder,
    super.outsideWorking,
    super.visaRequest,
    super.exitPermission,
    super.complaintRequest,
  });

  /// fromJson
  factory ExtraDataModel.fromJson(Map<String, dynamic> json) {
    return ExtraDataModel(
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
      // Note: CarPermission, ExitPermission, ComplaintRequestDetails might also need to be cast to models if they have toJson
      // but if we are only doing fromJson here, we use their existing fromJson if they have it.
      carPermission: json['carPermission'], // Assuming no fromJson needed here or handled differently
      exitPermission: json['exitPermission'],
      complaintRequest: json['complaintRequest'],
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'attendance': (attendance as AttendanceRequestDetailsModel?)?.toJson(),
      'study': (study as StudyModel?)?.toJson(),
      'startWork': (startWork as StartWorkModel?)?.toJson(),
      'experienceCertificate': (experienceCertificate as ExperienceCertificateModel?)?.toJson(),
      'idDocument': (idDocument as IDDocumentModel?)?.toJson(),
      'medicalInsurance': (medicalInsurance as MedicalInsuranceModel?)?.toJson(),
      'trainingRequest': (trainingRequest as TrainingRequestModel?)?.toJson(),
      'productOrder': (productOrder as ProductOrderModel?)?.toJson(),
      'outsideWorking': outsideWorking,
      'visaRequest': visaRequest,
      // 'exitPermission': exitPermission?.toJson(),
      // 'carPermission': carPermission?.toJson(),
      // 'complaintRequest': complaintRequest?.toJson(),
    };
  }
}
