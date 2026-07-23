import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/create_leave_request_response.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/create_leave_request_use_case.dart';

class UpdateLeaveRequestUseCase
    extends UseCase<CreateLeaveRequestResponse, UpdateLeaveRequestParams> {
  final LeavesRepository _repository;

  UpdateLeaveRequestUseCase(this._repository);

  @override
  Future<Either<Failure, CreateLeaveRequestResponse>> call({
    required UpdateLeaveRequestParams params,
  }) async {
    return await _repository.updateLeaveRequest(params: params);
  }
}

/// PUT /hr_leave/update/{requestId} — same body as create plus the
/// update-only fields.
class UpdateLeaveRequestParams extends Equatable {
  final int requestId;
  final CreateLeaveRequestParams data;
  final int? stageId;
  final bool requestUnitHours;
  final bool requestUnitHalf;
  final String? dateFromPeriod;
  final String sequenceNumber;
  final String editReasons;
  final String rejectReasons;

  /// Names of the fields the backend should persist on update.
  final List<String> fields;

  /// The full field set the update endpoint expects by default.
  static const List<String> defaultFields = [
    'id',
    'sequence_number',
    'state',
    'employee_id',
    'alternative_employee',
    'department_id',
    'alternative_department_id',
    'holiday_status_id',
    'resource_calendar_id',
    'first_approver_id',
    'second_approver_id',
    'third_approver_id',
    'study_approve_id',
    'validation_type',
    'request_date_from',
    'request_date_to',
    'request_hour_from',
    'request_hour_to',
    'holiday_type',
    'stage_id',
    'supported_attachment_ids',
    'request_unit_hours',
    'request_unit_half',
    'date_from_period',
    'edit_reasons',
    'reject_reasons',
  ];

  const UpdateLeaveRequestParams({
    required this.requestId,
    required this.data,
    this.stageId,
    this.requestUnitHours = false,
    this.requestUnitHalf = false,
    this.dateFromPeriod,
    this.sequenceNumber = '',
    this.editReasons = '',
    this.rejectReasons = '',
    this.fields = defaultFields,
  });

  Map<String, dynamic> toMap() => {
        ...data.toMap(),
        'stage_id': stageId,
        'request_unit_hours': requestUnitHours,
        'request_unit_half': requestUnitHalf,
        'date_from_period': dateFromPeriod,
        'sequence_number': sequenceNumber,
        'edit_reasons': editReasons,
        'reject_reasons': rejectReasons,
        'fields': fields,
      };

  @override
  List<Object?> get props => [
        requestId,
        data,
        stageId,
        requestUnitHours,
        requestUnitHalf,
        dateFromPeriod,
        sequenceNumber,
        editReasons,
        rejectReasons,
        fields,
      ];
}
