import '../entities/current_status.dart';

enum RequestStatusEnum {
  newRequest,
  managerApproval,
  hrApproval,
  hrManager,
  rejected,
  confirmed,
  approved,
  authorityHolder,
  notValid,
  cancel,
  done,
  none,
}

extension RequestStatusExtension on CurrentStatus {
  RequestStatusEnum getRequestStatusEnum({required String? serviceType}) {
    final tech = techName?.toLowerCase() ?? '';
    final ServiceType = serviceType?.toLowerCase() ?? '';

    // ────────────────────────────────────────────────────────────────
    // 1) Service-specific overrides — wins when present.
    //    Add a new branch here when a service has unusual tech names.
    // ────────────────────────────────────────────────────────────────
    switch (ServiceType) {
      case 'hr.exit.permission':
        switch (tech) {
          case 'new':
            return RequestStatusEnum.newRequest;
          case 'manger':
            return RequestStatusEnum.managerApproval;
          case 'hr_approval':
            return RequestStatusEnum.hrApproval;
          case 'done':
            return RequestStatusEnum.done;
          case 'reject':
            return RequestStatusEnum.rejected;
        }
        break;

      case 'car.permission':
        switch (tech) {
          case 'draft':
            return RequestStatusEnum.newRequest;
          case 'applied':
            return RequestStatusEnum.managerApproval;
          case 'confirm':
            return RequestStatusEnum.hrApproval;
          case 'hr_manager':
            return RequestStatusEnum.hrManager;
          case 'approve':
            return RequestStatusEnum.approved;
          case 'cancel':
            return RequestStatusEnum.cancel;
        }
        break;

      case 'attendance.update':
        switch (tech) {
          case 'draft':
            return RequestStatusEnum.newRequest;
          case 'manager_confirm':
            return RequestStatusEnum.managerApproval;
          case 'confirm':
            return RequestStatusEnum.confirmed;
          case 'hr_approve':
            return RequestStatusEnum.hrApproval;
          case 'approve':
            return RequestStatusEnum.approved;
          case 'reject':
            return RequestStatusEnum.rejected;
          case 'cancel':
            return RequestStatusEnum.cancel;
        }
        break;
      case 'study.request':
        switch (tech) {
          case 'draft':
            return RequestStatusEnum.newRequest;
          case 'applied':
            return RequestStatusEnum.managerApproval;
          case 'hr_manager':
            return RequestStatusEnum.confirmed;
          case 'authority_holder':
            return RequestStatusEnum.authorityHolder;
          case 'approve':
            return RequestStatusEnum.approved;
          case 'confirm':
            return RequestStatusEnum.confirmed;
          case 'reject':
            return RequestStatusEnum.rejected;
          case 'not_valid':
            return RequestStatusEnum.notValid;
        }
        break;
      case 'complaint.request':
        switch (tech) {
          case 'draft':
            return RequestStatusEnum.newRequest;
          case 'hr_manager':
            return RequestStatusEnum.managerApproval;
          case 'approve':
            return RequestStatusEnum.approved;
          case 'authority_holder':
            return RequestStatusEnum.authorityHolder;
          case 'reject':
            return RequestStatusEnum.rejected;
        }
        break;
      case 'start.work':
        switch (tech) {
          case 'new':
            return RequestStatusEnum.newRequest;
          case 'confirm':
            return RequestStatusEnum.managerApproval;
          case 'hr_manager':
            return RequestStatusEnum.hrManager;
          case 'reject':
            return RequestStatusEnum.rejected;
          case 'approved':
            return RequestStatusEnum.approved;
        }
        break;
    }

    if (tech.contains('reject') || tech.contains('cancel')) {
      return RequestStatusEnum.rejected;
    }
    if (tech.contains('done') ||
        tech.contains('accept') ||
        tech.contains('approved') ||
        tech.contains('closed') ||
        tech.contains('completed')) {
      return RequestStatusEnum.done;
    }
    if (tech.contains('hr') || tech.contains('final')) {
      return RequestStatusEnum.hrApproval;
    }
    if (tech.contains('manager') ||
        tech.contains('manger') ||
        tech.contains('direct')) {
      return RequestStatusEnum.managerApproval;
    }
    if (tech.contains('new') ||
        tech.contains('applied') ||
        tech.contains('draft') ||
        tech.contains('submit') ||
        tech.contains('created')) {
      return RequestStatusEnum.newRequest;
    }

    return RequestStatusEnum.none;
  }
}
