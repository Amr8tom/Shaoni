import 'package:shaoni/core/routing/route_names.dart';

import '../constants/service_codes.dart';

class ServiceRouteResolver {
  const ServiceRouteResolver._();

  static String catalogRouteFor(String? serviceCode) {
    final service = ServiceCode.fromCode(serviceCode);

    switch (service) {
      case ServiceCode.exitPermission:
        return DRoutesName.requestCertainService;
      case ServiceCode.attendanceUpdate:
        return DRoutesName.missingAttendanceHistory;
      default:
        return createRouteFor(serviceCode);
    }
  }

  static String updateRouteFor(String? serviceCode) {
    final service = ServiceCode.fromCode(serviceCode);

    switch (service) {
      case ServiceCode.exitPermission:
        return DRoutesName.requestCreateDetails;
      case ServiceCode.attendanceUpdate:
        return DRoutesName.createAttendanceRoute;
      default:
        return createRouteFor(serviceCode);
    }
  }

  static String createRouteFor(String? serviceCode) {
    switch (ServiceCode.fromCode(serviceCode)) {
      case ServiceCode.outsideWorking:
        return DRoutesName.createOutsideWorkingRoute;
      case ServiceCode.productRequest:
        return DRoutesName.createProductOrderRoute;
      case ServiceCode.carPermission:
        return DRoutesName.createCarPermissionRoute;
      case ServiceCode.studyRequest:
        return DRoutesName.createStudyRequestRoute;
      case ServiceCode.startWork:
        return DRoutesName.createStartWorkRoute;
      case ServiceCode.idRenewalRequest:
        return DRoutesName.createIDDocumentRoute;
      case ServiceCode.complaintRequest:
        return DRoutesName.createComplaintRequestRoute;
      case ServiceCode.trainingRequest:
        return DRoutesName.createTrainingRequestRoute;
      case ServiceCode.medicalInsuranceUpgrade:
        return DRoutesName.createMedicalInsuranceRoute;
      case ServiceCode.experienceCertificate:
        return DRoutesName.createExperienceCertificateRoute;
      case ServiceCode.salaryTransfer:
        return DRoutesName.createSalaryTransferRoute;
      case ServiceCode.loan:
        return DRoutesName.createLoanRoute;
      case ServiceCode.scrapRequest:
        return DRoutesName.createScrapRequestRoute;
      case ServiceCode.visaRequest:
        return DRoutesName.createVisaRequestRoute;
      case ServiceCode.employeeTicketBooking:
        return DRoutesName.createTicketBookingRoute;
      case ServiceCode.leaveInterruptionRequest:
        return DRoutesName.createLeaveInterruptionRoute;

      case ServiceCode.exitPermission:
      case ServiceCode.attendanceUpdate:
      case ServiceCode.leaveReplace:
      case ServiceCode.leave:
      case null:
        return DRoutesName.noDataRoute;
    }
  }
}
