import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/create_leave_interruption_response.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';

class CreateLeaveInterruptionUseCase extends UseCase<
    CreateLeaveInterruptionResponse, CreateLeaveInterruptionParams> {
  final LeavesRepository _repository;

  CreateLeaveInterruptionUseCase(this._repository);

  @override
  Future<Either<Failure, CreateLeaveInterruptionResponse>> call({
    required CreateLeaveInterruptionParams params,
  }) async {
    return await _repository.createLeaveInterruption(params: params);
  }
}

class LeaveAttachmentParams extends Equatable {
  final String name;
  final String attachment;

  const LeaveAttachmentParams({this.name = '', this.attachment = ''});

  Map<String, dynamic> toMap() => {
        'name': name,
        'attachment': attachment,
      };

  @override
  List<Object?> get props => [name, attachment];
}

class CreateLeaveInterruptionParams extends Equatable {
  final int employeeId;
  final String requestDate;
  final int leaveInterruptionTypeId;
  final int leaveTypeId;
  final int leaveId;
  final String leaveInterruptionDate;
  final String reasons;
  final List<LeaveAttachmentParams> attachmentIds;

  const CreateLeaveInterruptionParams({
    required this.employeeId,
    required this.requestDate,
    required this.leaveInterruptionTypeId,
    required this.leaveTypeId,
    required this.leaveId,
    required this.leaveInterruptionDate,
    this.reasons = '',
    this.attachmentIds = const [],
  });

  Map<String, dynamic> toMap() => {
        'employee_id': employeeId,
        'request_date': requestDate,
        'leave_interruption_type_id': leaveInterruptionTypeId,
        'leave_type_id': leaveTypeId,
        'leave_id': leaveId,
        'leave_interruption_date': leaveInterruptionDate,
        'leave_interruption_request_reasons': reasons,
        'leave_interruption_request_attachment_ids':
            attachmentIds.map((a) => a.toMap()).toList(),
      };

  @override
  List<Object?> get props => [
        employeeId,
        requestDate,
        leaveInterruptionTypeId,
        leaveTypeId,
        leaveId,
        leaveInterruptionDate,
        reasons,
        attachmentIds,
      ];
}
