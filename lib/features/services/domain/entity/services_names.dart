import 'package:equatable/equatable.dart';
import 'package:shaoni/core/constants/service_codes.dart';

class ServicesNames extends Equatable {
  static List<ServiceCode> hrServiceKeys = [
    ServiceCode.outsideWorking,
    ServiceCode.attendanceUpdate,
    ServiceCode.exitPermission,
    ServiceCode.carPermission,
    ServiceCode.startWork,
    ServiceCode.idRenewalRequest,
    ServiceCode.complaintRequest,
    ServiceCode.medicalInsuranceUpgrade,
    ServiceCode.experienceCertificate,
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
  static List<ServiceCode> reservationServiceKeys = [
    ServiceCode.visaRequest,
        ServiceCode.employeeTicketBooking,

  ];
  static List<ServiceCode> leaveServiceKeys = [
ServiceCode.leaveReplace,
    ServiceCode.leave,
    ServiceCode.leaveInterruptionRequest,
  ];

  @override
  List<Object?> get props => [
    hrServiceKeys,
    studyServiceKeys,
    productServiceKeys,
    salariesServiceKeys,
    reservationServiceKeys,
    leaveServiceKeys,
  ];
}
