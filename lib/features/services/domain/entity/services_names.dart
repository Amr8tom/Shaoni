import 'package:equatable/equatable.dart';
import 'package:shaoni/core/constants/service_codes.dart';

class ServicesNames extends Equatable {
  static List<ServiceCode> hrServiceKeys = [
    ServiceCode.outsideWorking,
    ServiceCode.attendanceUpdate,
    ServiceCode.exitPermission,
    ServiceCode.loan,
    ServiceCode.visaRequest,
    ServiceCode.carPermission,
    ServiceCode.scrapRequest,
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
  ];
  static List<ServiceCode> salariesServiceKeys = [
    ServiceCode.salaryTransfer,
  ];

  @override
  List<Object?> get props => [
    hrServiceKeys,
    studyServiceKeys,
    productServiceKeys,
    salariesServiceKeys,
  ];
}
