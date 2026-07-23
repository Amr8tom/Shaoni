import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/create_leave_request_response.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';

class CreateLeaveRequestUseCase
    extends UseCase<CreateLeaveRequestResponse, CreateLeaveRequestParams> {
  final LeavesRepository _repository;

  CreateLeaveRequestUseCase(this._repository);

  @override
  Future<Either<Failure, CreateLeaveRequestResponse>> call({
    required CreateLeaveRequestParams params,
  }) async {
    return await _repository.createLeaveRequest(params: params);
  }
}

/// One entry of `supported_attachment_ids`.
///
/// A newly-picked file sends `{name, attachment(base64)}`; an existing file
/// kept on update sends `{id, name, url}`.
class LeaveRequestAttachmentParams extends Equatable {
  final int? id;
  final String name;

  /// base64 payload (new files only)
  final String attachment;

  /// server url (existing files only)
  final String url;

  const LeaveRequestAttachmentParams({
    this.id,
    this.name = '',
    this.attachment = '',
    this.url = '',
  });

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'name': name,
        if (attachment.isNotEmpty) 'attachment': attachment,
        if (url.isNotEmpty) 'url': url,
      };

  @override
  List<Object?> get props => [id, name, attachment, url];
}

class CreateLeaveRequestParams extends Equatable {
  /// "الوضع" — the web form submits this fixed as `employee`.
  final String holidayType;
  final int employeeId;
  final int? alternativeEmployee;
  final int? departmentId;
  final int? alternativeDepartmentId;

  /// The selected leave type.
  final int holidayStatusId;
  final int? resourceCalendarId;
  final int? firstApproverId;
  final int? secondApproverId;
  final int? thirdApproverId;
  final int? studyApproveId;

  /// Comes from the selected leave type's `leaveValidationType`.
  final String validationType;
  final String requestDateFrom;
  final String requestDateTo;
  final String requestHourFrom;
  final String requestHourTo;
  final List<LeaveRequestAttachmentParams> supportedAttachmentIds;

  const CreateLeaveRequestParams({
    this.holidayType = 'employee',
    required this.employeeId,
    this.alternativeEmployee,
    this.departmentId,
    this.alternativeDepartmentId,
    required this.holidayStatusId,
    this.resourceCalendarId,
    this.firstApproverId,
    this.secondApproverId,
    this.thirdApproverId,
    this.studyApproveId,
    required this.validationType,
    required this.requestDateFrom,
    required this.requestDateTo,
    this.requestHourFrom = '0',
    this.requestHourTo = '0',
    this.supportedAttachmentIds = const [],
  });

  Map<String, dynamic> toMap() => {
        'holiday_type': holidayType,
        'employee_id': employeeId,
        'alternative_employee': alternativeEmployee,
        'department_id': departmentId,
        'alternative_department_id': alternativeDepartmentId,
        'holiday_status_id': holidayStatusId,
        'resource_calendar_id': resourceCalendarId,
        'first_approver_id': firstApproverId,
        'second_approver_id': secondApproverId,
        'third_approver_id': thirdApproverId,
        'study_approve_id': studyApproveId,
        'validation_type': validationType,
        'request_date_from': requestDateFrom,
        'request_date_to': requestDateTo,
        'request_hour_from': requestHourFrom,
        'request_hour_to': requestHourTo,
        'supported_attachment_ids':
            supportedAttachmentIds.map((a) => a.toMap()).toList(),
      };

  @override
  List<Object?> get props => [
        holidayType,
        employeeId,
        alternativeEmployee,
        departmentId,
        alternativeDepartmentId,
        holidayStatusId,
        resourceCalendarId,
        firstApproverId,
        secondApproverId,
        thirdApproverId,
        studyApproveId,
        validationType,
        requestDateFrom,
        requestDateTo,
        requestHourFrom,
        requestHourTo,
        supportedAttachmentIds,
      ];
}
