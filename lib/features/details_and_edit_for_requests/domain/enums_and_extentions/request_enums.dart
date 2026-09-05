import '../../../../core/constants/service_codes.dart';
import '../../../../generated/l10n.dart';
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
          RequestStatusEnum.draft, // draft
          RequestStatusEnum.confirmed, // confirm → اعتماد المدير المباشر
          RequestStatusEnum.hrManager, // hr_manager → موافقة صاحب الصلاحية
          RequestStatusEnum.approved, // approve → معتمد
          RequestStatusEnum.rejected, // reject
          RequestStatusEnum.cancel, // cancel
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
      case ServiceCode.leaveInterruptionRequest:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.hrApproval,
          RequestStatusEnum.approved,
          RequestStatusEnum.rejected,
        ];
      case ServiceCode.leaveReplace:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.hr,
          RequestStatusEnum.approved,
          RequestStatusEnum.rejected,
        ];
      case ServiceCode.outsideWorking:
        return const [
          RequestStatusEnum.newRequest,
          RequestStatusEnum.inProgress,
          RequestStatusEnum.topManager,
          RequestStatusEnum.budget,
          RequestStatusEnum.achievement,
          RequestStatusEnum.approved,
          RequestStatusEnum.achievementTwo,
          RequestStatusEnum.approveTwo,
          RequestStatusEnum.finalStage,
          RequestStatusEnum.rejected,
        ];
      case ServiceCode.leave:
        return const [
          RequestStatusEnum.draft,
          RequestStatusEnum.confirmed,
          RequestStatusEnum.managerApproval,
          RequestStatusEnum.hrApproval,
          RequestStatusEnum.approved,
          RequestStatusEnum.rejected,
          RequestStatusEnum.cancel,
        ];
      case ServiceCode.scrapRequest:
        return const [
          RequestStatusEnum.draft, // draft
          RequestStatusEnum.approved, // approve → Submitted
          RequestStatusEnum.confirmed, // confirmed
          RequestStatusEnum.done, // done → Transfer Done
          RequestStatusEnum.saleDone, // sale → Sale done
          RequestStatusEnum.rejected, // reject
          RequestStatusEnum.cancel, // cancel
        ];
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
      case 'sale':
        return RequestStatusEnum.saleDone;
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

      // ---- Outside Working States ----
      case 'in_progress':
        return RequestStatusEnum.inProgress;
      case 'manager1':
        return RequestStatusEnum.topManager;
      case 'budget':
        return RequestStatusEnum.budget;
      case 'achievement':
        return RequestStatusEnum.achievement;
      case 'achievement2':
        return RequestStatusEnum.achievementTwo;
      case 'approve2':
        return RequestStatusEnum.approveTwo;
      case 'final':
        return RequestStatusEnum.finalStage;

      // ---- Leave Request (hr.leave) States ----
      case 'validate1':
        return RequestStatusEnum.managerApproval;
      case 'validate2':
        return RequestStatusEnum.hrApproval;
      case 'validate':
        return RequestStatusEnum.approved;
      case 'refuse':
        return RequestStatusEnum.rejected;

      default:
        return RequestStatusEnum.none;
    }
  }
}

extension RequestStatusEnumLocalized on RequestStatusEnum {
  /// Localized display label for a workflow stage (falls back to the raw
  /// enum name for [RequestStatusEnum.none]).
  String get label {
    switch (this) {
      case RequestStatusEnum.newRequest:
        return S.current.statusNewRequest;
      case RequestStatusEnum.draft:
        return S.current.statusDraft;
      case RequestStatusEnum.applied:
        return S.current.statusApplied;
      case RequestStatusEnum.employeeApprove:
        return S.current.statusEmployeeApprove;
      case RequestStatusEnum.budget:
        return S.current.statusBudget;
      case RequestStatusEnum.emp:
        return S.current.statusEmp;
      case RequestStatusEnum.specifications:
        return S.current.statusSpecifications;
      case RequestStatusEnum.managerApproval:
        return S.current.statusManagerApproval;
      case RequestStatusEnum.hr:
        return S.current.statusHr;
      case RequestStatusEnum.hrApproval:
        return S.current.statusHrApproval;
      case RequestStatusEnum.hrManager:
        return S.current.statusHrManager;
      case RequestStatusEnum.rejected:
        return S.current.statusRejected;
      case RequestStatusEnum.confirmed:
        return S.current.statusConfirmed;
      case RequestStatusEnum.approved:
        return S.current.statusApproved;
      case RequestStatusEnum.authorityHolder:
        return S.current.statusAuthorityHolder;
      case RequestStatusEnum.externalRelations:
        return S.current.statusExternalRelations;
      case RequestStatusEnum.notValid:
        return S.current.statusNotValid;
      case RequestStatusEnum.cancel:
        return S.current.statusCancel;
      case RequestStatusEnum.closed:
        return S.current.statusClosed;
      case RequestStatusEnum.done:
        return S.current.statusDone;
      case RequestStatusEnum.saleDone:
        return S.current.statusSaleDone;
      case RequestStatusEnum.inProgress:
        return S.current.statusInProgress;
      case RequestStatusEnum.topManager:
        return S.current.statusTopManager;
      case RequestStatusEnum.achievement:
        return S.current.statusAchievement;
      case RequestStatusEnum.achievementTwo:
        return S.current.statusAchievementTwo;
      case RequestStatusEnum.approveTwo:
        return S.current.statusApproveTwo;
      case RequestStatusEnum.finalStage:
        return S.current.statusFinalStage;
      case RequestStatusEnum.none:
        return '';
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
  saleDone,
  // outside working
  inProgress,
  topManager,
  achievement,
  achievementTwo,
  approveTwo,
  finalStage,
  none,
}
