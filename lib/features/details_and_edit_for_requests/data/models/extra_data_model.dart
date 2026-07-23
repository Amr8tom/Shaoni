import 'package:shaoni/features/details_and_edit_for_requests/data/models/attendance_request_details_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/experience_certificate_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/id_document_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/medical_insurance_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/product_order_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/start_work_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/study_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/training_request_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/car_permission/car_permission.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/complaint_request/complaint_request_details.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/extra_data.dart';
import 'package:shaoni/features/human_resources/domain/entity/exit_permisstion.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/loan_request_details_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/salary_request_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/scrap_request_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/visa_request_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/ticket_booking_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/leave_interruption_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/leave_replace_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/outside_working_details_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/leave_request_model.dart';

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
    super.salaryRequest,
    super.loanRequest,
    super.scrapRequest,
    super.ticketBooking,
    super.leaveInterruption,
    super.leaveReplace,
    super.leaveRequest,
  });

  /// fromJson
  factory ExtraDataModel.fromJson(Map<String, dynamic> json) {
    final attendanceJson = _jsonMap(json['attendance']);
    final studyJson = _jsonMap(json['study']);
    final startWorkJson = _jsonMap(json['startWorking']);
    final experienceCertificateJson = _jsonMap(json['experienceCertificate']);
    final idDocumentJson =
        _jsonMap(json['idDocument']) ?? _jsonMap(json['idRenewalRequest']);
    final medicalInsuranceJson = _jsonMap(json['medicalInsurance']);
    final trainingRequestJson = _jsonMap(json['trainingRequest']);
    final productOrderJson = _jsonMap(json['productOrder']);
    final carPermissionJson = _jsonMap(json['carPermission']);
    final exitPermissionJson = _jsonMap(json['exitPermission']);
    final complaintRequestJson = _jsonMap(json['complaintRequest']);
    final salaryRequestJson = _jsonMap(json['salaryRequest']);
    final loanRequestJson = _jsonMap(json['loanRequest']);
    final scrapRequestJson = _jsonMap(json['scrapRequest']);
    final visaRequestJson = _jsonMap(json['visaRequest']);
    final ticketBookingJson = _jsonMap(json['ticketBooking']);
    final leaveInterruptionJson = _jsonMap(json['leaveInterruption']);
    final leaveReplaceJson = _jsonMap(json['leaveReplace']);
    final leaveRequestJson = _jsonMap(json['leaveRequest']);

    return ExtraDataModel(
      attendance: attendanceJson != null
          ? AttendanceRequestDetailsModel.fromJson(attendanceJson)
          : null,
      study: studyJson != null ? StudyModel.fromJson(studyJson) : null,
      startWork:
          startWorkJson != null ? StartWorkModel.fromJson(startWorkJson) : null,
      experienceCertificate: experienceCertificateJson != null
          ? ExperienceCertificateModel.fromJson(experienceCertificateJson)
          : null,
      idDocument: idDocumentJson != null
          ? IDDocumentModel.fromJson(idDocumentJson)
          : null,
      medicalInsurance: medicalInsuranceJson != null
          ? MedicalInsuranceModel.fromJson(medicalInsuranceJson)
          : null,
      trainingRequest: trainingRequestJson != null
          ? TrainingRequestModel.fromJson(trainingRequestJson)
          : null,
      productOrder: productOrderJson != null
          ? ProductOrderModel.fromJson(productOrderJson)
          : null,
      outsideWorking: _jsonMap(json['outsideWorking']) != null
          ? OutsideWorkingDetailsModel.fromJson(
              _jsonMap(json['outsideWorking'])!)
          : null,
      visaRequest: visaRequestJson != null
          ? VisaRequestModel.fromJson(visaRequestJson)
          : null,
      carPermission: carPermissionJson != null
          ? CarPermission.fromJson(carPermissionJson)
          : null,
      exitPermission: exitPermissionJson != null
          ? ExitPermission.fromJson(exitPermissionJson)
          : null,
      complaintRequest: complaintRequestJson != null
          ? ComplaintRequestDetails.fromJson(complaintRequestJson)
          : null,
      salaryRequest: salaryRequestJson != null
          ? SalaryRequestModel.fromJson(salaryRequestJson)
          : null,
      loanRequest: loanRequestJson != null
          ? LoanRequestDetailsModel.fromJson(loanRequestJson)
          : null,
      scrapRequest: scrapRequestJson != null
          ? ScrapRequestModel.fromJson(scrapRequestJson)
          : null,
      ticketBooking: ticketBookingJson != null
          ? TicketBookingModel.fromJson(ticketBookingJson)
          : null,
      leaveInterruption: leaveInterruptionJson != null
          ? LeaveInterruptionModel.fromJson(leaveInterruptionJson)
          : null,
      leaveReplace: leaveReplaceJson != null
          ? LeaveReplaceModel.fromJson(leaveReplaceJson)
          : null,
      leaveRequest: leaveRequestJson != null
          ? LeaveRequestModel.fromJson(leaveRequestJson)
          : null,
    );
  }

  static Map<String, dynamic>? _jsonMap(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
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
              'externalName': extraData.idDocument!.externalName,
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
              'editReasons': extraData.idDocument!.editReasons,
              'rejectReasons': extraData.idDocument!.rejectReasons,
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
      'outsideWorking': extraData.outsideWorking == null
          ? null
          : OutsideWorkingDetailsModel.toJsonFromEntity(
              extraData.outsideWorking!),
      'visaRequest': extraData.visaRequest == null
          ? null
          : VisaRequestModel.toJsonFromEntity(extraData.visaRequest!),
      'exitPermission': extraData.exitPermission?.toJson(),
      'carPermission': extraData.carPermission?.toJson(),
      'complaintRequest': extraData.complaintRequest?.toJson(),
      'salaryRequest': extraData.salaryRequest != null
          ? SalaryRequestModel.toJsonFromEntity(extraData.salaryRequest!)
          : null,
      'loanRequest': extraData.loanRequest != null
          ? LoanRequestDetailsModel.toJsonFromEntity(extraData.loanRequest!)
          : null,
      'scrapRequest': extraData.scrapRequest == null
          ? null
          : {
              'custodyId': extraData.scrapRequest!.custodyId,
              'custodyName': extraData.scrapRequest!.custodyName,
              'stockRequestId': extraData.scrapRequest!.stockRequestId,
              'stockRequestName': extraData.scrapRequest!.stockRequestName,
              'reasonId': extraData.scrapRequest!.reasonId,
              'reasonName': extraData.scrapRequest!.reasonName,
              'editReasons': extraData.scrapRequest!.editReasons,
              'rejectReasons': extraData.scrapRequest!.rejectReasons,
              'lines': extraData.scrapRequest!.lines
                  .map((l) => {
                        'productId': l.productId,
                        'productName': l.productName,
                        'quantity': l.quantity,
                        'lotId': l.lotId,
                        'lotName': l.lotName,
                        'reason': l.reason,
                      })
                  .toList(),
            },
      'ticketBooking': extraData.ticketBooking == null
          ? null
          : TicketBookingModel.toJsonFromEntity(extraData.ticketBooking!),
      'leaveInterruption': extraData.leaveInterruption == null
          ? null
          : LeaveInterruptionModel.toJsonFromEntity(
              extraData.leaveInterruption!),
      'leaveReplace': extraData.leaveReplace == null
          ? null
          : LeaveReplaceModel.toJsonFromEntity(extraData.leaveReplace!),
      'leaveRequest': extraData.leaveRequest == null
          ? null
          : LeaveRequestModel.toJsonFromEntity(extraData.leaveRequest!),
    };
  }
}
