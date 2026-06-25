import 'package:equatable/equatable.dart';
import 'package:shaoni/core/constants/service_codes.dart';

class ServicesNames extends Equatable {
  static List<ServiceCode> hrServiceKeys = [
    ServiceCode.outsideWorking,
    ServiceCode.attendanceUpdate,
    ServiceCode.exitPermission,
    ServiceCode.visaRequest,
    ServiceCode.carPermission,
    ServiceCode.startWork,
    ServiceCode.employeeTicketBooking,
    ServiceCode.idRenewalRequest,
    ServiceCode.complaintRequest,
    ServiceCode.medicalInsuranceUpgrade,
    ServiceCode.experienceCertificate,
    ServiceCode.leaveReplace,
    ServiceCode.leave,
    ServiceCode.leaveInterruptionRequest,
  ];
  static List<ServiceCode> studyServiceKeys = [
    ServiceCode.studyRequest,
    ServiceCode.trainingRequest,
  ];
  static List<ServiceCode> productServiceKeys = [
    ServiceCode.productRequest,
    ServiceCode.scrapRequest,
  ];
  static List<ServiceCode> salariesServiceKeys = [
    ServiceCode.salaryTransfer,
    ServiceCode.loan,

  ];

  @override
  List<Object?> get props => [
    hrServiceKeys,
    studyServiceKeys,
    productServiceKeys,
    salariesServiceKeys,
  ];
}
