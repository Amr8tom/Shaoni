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
      carPermission: json[
          'carPermission'], // Assuming no fromJson needed here or handled differently
      exitPermission: json['exitPermission'],
      complaintRequest: json['complaintRequest'],
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(ExtraData extraData) {
    return {
      'attendance': extraData.attendance == null
          ? null
          : {
              'id': extraData.attendance!.id,
              'attendanceId': extraData.attendance!.attendanceId,
              'orderReason': extraData.attendance!.orderReason,
              'notes': extraData.attendance!.notes,
              'attendanceType': extraData.attendance!.attendanceType,
              'forgetReason': extraData.attendance!.forgetReason,
              'missingAttendance': extraData.attendance!.missingAttendance,
            },
      'study': extraData.study == null
          ? null
          : {
              'requestType': extraData.study!.requestType,
              'requestTypeLabel': extraData.study!.requestTypeLabel,
              'study': extraData.study!.study,
              'studyDestinationsText': extraData.study!.studyDestinationsText,
              'studyDestinationId': extraData.study!.studyDestinationId,
              'studyStartDate': extraData.study!.studyStartDate,
              'studyEndDate': extraData.study!.studyEndDate,
              'note': extraData.study!.note,
              'reason': extraData.study!.reason,
              'comment': extraData.study!.comment,
              'editReasons': extraData.study!.editReasons,
              'rejectReasons': extraData.study!.rejectReasons,
              'attachments': extraData.study!.attachments,
            },
      'startWork': extraData.startWork == null
          ? null
          : {
              'externalName': extraData.startWork!.externalName,
              'date': extraData.startWork!.date,
              'startDate': extraData.startWork!.startDate,
              'typeId': extraData.startWork!.typeId,
              'typeName': extraData.startWork!.typeName,
              'employeeId': extraData.startWork!.employeeId,
              'managerId': extraData.startWork!.managerId,
              'managerName': extraData.startWork!.managerName,
              'note': extraData.startWork!.note,
              'attachment': extraData.startWork!.attachment,
              'state': extraData.startWork!.state,
              'editReasons': extraData.startWork!.editReasons,
              'rejectReasons': extraData.startWork!.rejectReasons,
            },
      'experienceCertificate': extraData.experienceCertificate == null
          ? null
          : {
              'externalName': extraData.experienceCertificate!.externalName,
              'date': extraData.experienceCertificate!.date,
              'certificateReasonId':
                  extraData.experienceCertificate!.certificateReasonId,
              'certificateReasonName':
                  extraData.experienceCertificate!.certificateReasonName,
              'reason': extraData.experienceCertificate!.reason,
              'note': extraData.experienceCertificate!.note,
              'state': extraData.experienceCertificate!.state,
              'certificateUrl': extraData.experienceCertificate!.certificateUrl,
              'editReasons': extraData.experienceCertificate!.editReasons,
              'rejectReasons': extraData.experienceCertificate!.rejectReasons,
            },
      'idDocument': extraData.idDocument == null
          ? null
          : {
              'id': extraData.idDocument!.id,
              'requestType': extraData.idDocument!.requestType,
              'documentType': extraData.idDocument!.documentType,
              'issuingCountry': extraData.idDocument!.issuingCountry,
              'documentNumber': extraData.idDocument!.documentNumber,
              'issueNumber': extraData.idDocument!.issueNumber,
              'issueDate': extraData.idDocument!.issueDate,
              'endDate': extraData.idDocument!.endDate,
              'tabaq': extraData.idDocument!.tabaq,
              'kafala': extraData.idDocument!.kafala,
              'kafeelName': extraData.idDocument!.kafeelName,
              'passportNumber': extraData.idDocument!.passportNumber,
              'passportAddress': extraData.idDocument!.passportAddress,
              'familyCardNumber': extraData.idDocument!.familyCardNumber,
              'drivingLicenseNumber':
                  extraData.idDocument!.drivingLicenseNumber,
              'date': extraData.idDocument!.date,
            },
      'medicalInsurance': extraData.medicalInsurance == null
          ? null
          : {
              'externalName': extraData.medicalInsurance!.externalName,
              'date': extraData.medicalInsurance!.date,
              'insuranceClassName':
                  extraData.medicalInsurance!.insuranceClassName,
              'includeFamilyMember':
                  extraData.medicalInsurance!.includeFamilyMember,
              'reasonForUpgrade': extraData.medicalInsurance!.reasonForUpgrade,
              'note': extraData.medicalInsurance!.note,
              'state': extraData.medicalInsurance!.state,
              'editReasons': extraData.medicalInsurance!.editReasons,
              'rejectReasons': extraData.medicalInsurance!.rejectReasons,
            },
      'trainingRequest': extraData.trainingRequest == null
          ? null
          : {
              'courseId': extraData.trainingRequest!.courseId,
              'courseName': extraData.trainingRequest!.courseName,
              'startDate': extraData.trainingRequest!.startDate,
              'endDate': extraData.trainingRequest!.endDate,
              'nominationStartDate':
                  extraData.trainingRequest!.nominationStartDate,
              'nominationEndDate': extraData.trainingRequest!.nominationEndDate,
              'coursePeriodMonths':
                  extraData.trainingRequest!.coursePeriodMonths,
              'nominationPeriodDays':
                  extraData.trainingRequest!.nominationPeriodDays,
              'note': extraData.trainingRequest!.note,
              'attachment': extraData.trainingRequest!.attachment,
              'editReasons': extraData.trainingRequest!.editReasons,
              'rejectReasons': extraData.trainingRequest!.rejectReasons,
              'stageName': extraData.trainingRequest!.stageName,
            },
      'productOrder': extraData.productOrder == null
          ? null
          : {
              'isGift': extraData.productOrder!.isGift,
              'reason': extraData.productOrder!.reason,
              'note': extraData.productOrder!.note,
              'editReasons': extraData.productOrder!.editReasons,
              'rejectReasons': extraData.productOrder!.rejectReasons,
              'lines': extraData.productOrder!.lines
                  .map(ProductOrderLineItem.toJsonFromEntity)
                  .toList(),
            },
      'outsideWorking': extraData.outsideWorking,
      'visaRequest': extraData.visaRequest,
      // 'exitPermission': exitPermission?.toJson(),
      // 'carPermission': carPermission?.toJson(),
      // 'complaintRequest': complaintRequest?.toJson(),
    };
  }
}
