import '../entities/current_status.dart';

extension RequestStatusExtension on CurrentStatus {
  RequestStatusEnum getRequestStatusEnum() {
    switch (this.techName) {
      case "manger":
        return RequestStatusEnum.newRequest;
      case "applied":
        return RequestStatusEnum.newRequest;
      case "hr_manager":
        return RequestStatusEnum.hrApproval;

      default:
        return RequestStatusEnum.none;
    }
  }
}

enum RequestStatusEnum {
  newRequest,
  managerApproval,
  hrApproval,
  rejected,
  approved,
  done,
  none,
}


