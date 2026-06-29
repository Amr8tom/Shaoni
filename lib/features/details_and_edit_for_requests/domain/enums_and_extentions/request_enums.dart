import '../../../../core/constants/service_codes.dart';
import '../entities/current_status.dart';

extension RequestStatusExtensionList on CurrentStatus {
  List<RequestStatusEnum> getRequestStatusEnumList(
      {required String? serviceType}) {
    final tech = techName?.toLowerCase() ?? '';

    switch (ServiceCode.fromCode(serviceType)) {
      case ServiceCode.exitPermission:
        return const [
          RequestStatusEnum.newRequest,
          RequestStatusEnum.managerApproval,
          RequestStatusEnum.hrApproval,
          RequestStatusEnum.done,
          RequestStatusEnum.rejected
        ];

      case ServiceCode.carPermission:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.applied,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.hrManager,
          RequestStatusEnum.rejected,
          RequestStatusEnum.cancel,
          RequestStatusEnum.approved
        ];

      case ServiceCode.attendanceUpdate:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.managerApproval,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.hrApproval,
          RequestStatusEnum.approved,
          RequestStatusEnum.rejected,
          RequestStatusEnum.cancel
        ];

      case ServiceCode.studyRequest:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.applied,
          RequestStatusEnum.hrManager,
          RequestStatusEnum.authorityHolder,
          RequestStatusEnum.approved,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.rejected,
          RequestStatusEnum.notValid
        ];

      case ServiceCode.complaintRequest:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.hrManager,
          RequestStatusEnum.approved,
          RequestStatusEnum.rejected
        ];

      case ServiceCode.startWork:
        return const [
          RequestStatusEnum.newRequest,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.hrManager,
          RequestStatusEnum.approved,
          RequestStatusEnum.rejected,
        ];

      case ServiceCode.idRenewalRequest:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.hrManager,
          RequestStatusEnum.approved,
          RequestStatusEnum.rejected,
        ];

      case ServiceCode.experienceCertificate:
        return const [
          RequestStatusEnum.newRequest,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.rejected,
          RequestStatusEnum.approved
        ];

      case ServiceCode.medicalInsuranceUpgrade:
        return const [
          RequestStatusEnum.newRequest,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.hrManager,
          RequestStatusEnum.employeeApprove,
          RequestStatusEnum.budget,
          RequestStatusEnum.authorityHolder,
          RequestStatusEnum.rejected,
          RequestStatusEnum.approved,
          RequestStatusEnum.cancel
        ];

      case ServiceCode.trainingRequest:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.approved,
          RequestStatusEnum.rejected
        ];
      case ServiceCode.productRequest:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.specifications,
          RequestStatusEnum.approved,
          RequestStatusEnum.closed,
          RequestStatusEnum.cancel,
          RequestStatusEnum.rejected,
        ];
      case ServiceCode.salaryTransfer:
        return const [
          RequestStatusEnum.newRequest,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.approved,
          RequestStatusEnum.rejected,
        ];
      case ServiceCode.loan:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.emp,
          RequestStatusEnum.hr,
          RequestStatusEnum.hrApproval,
          RequestStatusEnum.rejected,
        ];
      case ServiceCode.visaRequest:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.hrApproval,
          RequestStatusEnum.externalRelations,
          RequestStatusEnum.authorityHolder,
          RequestStatusEnum.approved,
          RequestStatusEnum.rejected,
        ];
      case ServiceCode.employeeTicketBooking:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.rejected,
          RequestStatusEnum.hrApproval,
          RequestStatusEnum.approved,
        ];
      case ServiceCode.outsideWorking:
      case ServiceCode.scrapRequest:
      case ServiceCode.leaveReplace:
      case ServiceCode.leave:
      case ServiceCode.leaveInterruptionRequest:
      case null:
        break;
    }

    if (tech.contains('reject') || tech.contains('cancel')) {
      return const [RequestStatusEnum.rejected];
    }
    if (tech.contains('done') ||
        tech.contains('accept') ||
        tech.contains('approved') ||
        tech.contains('closed') ||
        tech.contains('completed')) {
      return [RequestStatusEnum.done];
    }
    if (tech.contains('hr') || tech.contains('final')) {
      return const [RequestStatusEnum.hrApproval];
    }
    if (tech.contains('manager') ||
        tech.contains('manger') ||
        tech.contains('direct')) {
      return const [RequestStatusEnum.managerApproval];
    }
    if (tech.contains('new') ||
        tech.contains('applied') ||
        tech.contains('draft') ||
        tech.contains('submit') ||
        tech.contains('created')) {
      return const [RequestStatusEnum.newRequest];
    }

    return const [RequestStatusEnum.none];
  }
}

extension RequestStatusStringExtension on String? {
  RequestStatusEnum get toRequestStatusEnum {
    final tech = this?.toLowerCase() ?? '';
    switch (tech) {
      // ---- New / Draft States ----
      case 'new':
        return RequestStatusEnum.newRequest;

      case 'draft':
        return RequestStatusEnum.draft;

      // ---- Loan-specific States ----
      case 'emp':
        return RequestStatusEnum.emp;

      // ---- Manager Level States ----
      case 'manger':
        return RequestStatusEnum.managerApproval;
      case 'applied':
        return RequestStatusEnum.applied;
      case 'manager_confirm':
        return RequestStatusEnum.managerApproval;
      case 'confirmed':
        return RequestStatusEnum.confirmed;

      // ---- HR / Approval States ----
      case 'hr':
        return RequestStatusEnum.hr;
      case 'hr_approval':
      case 'hr_approve':
        return RequestStatusEnum.hrApproval;

      // ---- Final Approved States ----
      case 'done':
        return RequestStatusEnum.done;
      case 'specifications':
        return RequestStatusEnum.specifications;
      case 'approve':
      case 'approved':
        return RequestStatusEnum.approved;

      case 'external_relations':
        return RequestStatusEnum.externalRelations;

      // ---- Rejection / Cancellation States ----
      case 'reject':
        return RequestStatusEnum.rejected;

      case 'cancel':
        return RequestStatusEnum.cancel;

      case 'close':
        return RequestStatusEnum.closed;
      case 'employee_approve':
        return RequestStatusEnum.employeeApprove;

      case 'not_valid':
        return RequestStatusEnum.notValid;

      case 'authority_holder':
        return RequestStatusEnum.authorityHolder;

      // ---- Context Overlapping Conflicts ----
      case 'confirm':
        return RequestStatusEnum.confirmed;

      case 'hr_manager':
        return RequestStatusEnum.hrManager;

      default:
        return RequestStatusEnum.none;
    }
  }
}

enum RequestStatusEnum {
  newRequest,
  draft,
  applied,
  employeeApprove,
  budget,
  emp,
  specifications,
  managerApproval,
  hr,
  hrApproval,
  hrManager,
  rejected,
  confirmed,
  approved,
  authorityHolder,
  externalRelations,
  notValid,
  cancel,
  closed,
  done,
  none,
}
