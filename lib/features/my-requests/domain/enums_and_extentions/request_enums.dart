import '../entities/current_status.dart';

// extension RequestStatusExtension on CurrentStatus {
//   RequestStatusEnum getRequestStatusEnum() {
//     switch (this.techName) {
//       case "new":
//         return RequestStatusEnum.newRequest;
//       case "applied":
//         return RequestStatusEnum.newRequest;
//       case "draft":
//         return RequestStatusEnum.newRequest;
//       case "manger":
//         return RequestStatusEnum.managerApproval;
//       case "hr_manager":
//         return RequestStatusEnum.hrApproval;
//       case "hr_approval":
//         return RequestStatusEnum.hrApproval;
//       case "done":
//         return RequestStatusEnum.done;
//       case "reject":
//         return RequestStatusEnum.rejected;
//
//       default:
//         return RequestStatusEnum.none;
//     }
//   }
// }
//
enum RequestStatusEnum {
  newRequest,
  managerApproval,
  hrApproval,
  hrManager,
  rejected,
  confirmed,
  approved,
  cancel,
  done,
  none,
}

extension RequestStatusExtension on CurrentStatus {
  /// Resolves the unified UI status from this stage's [techName] AND the
  /// service it belongs to ([requestType]). Service-specific overrides are
  /// checked first; if nothing matches we fall back to the generic
  /// keyword mapping.
  ///
  /// Usage:
  /// ```
  /// final s = request.currentStatus.getRequestStatusEnum(request.serviceCode);
  /// ```
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
