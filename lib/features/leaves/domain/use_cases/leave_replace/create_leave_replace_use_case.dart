import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_replace/create_leave_replace_response.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';

class CreateLeaveReplaceUseCase
    extends UseCase<CreateLeaveReplaceResponse, CreateLeaveReplaceParams> {
  final LeavesRepository _repository;

  CreateLeaveReplaceUseCase(this._repository);

  @override
  Future<Either<Failure, CreateLeaveReplaceResponse>> call({
    required CreateLeaveReplaceParams params,
  }) async {
    return await _repository.createLeaveReplace(params: params);
  }
}

class CreateLeaveReplaceParams extends Equatable {
  final int employeeId;
  final String requestDate;
  final String leaveStartDate;
  final String leaveEndDate;
  final int leaveTypeId;
  final int leaveId;

  const CreateLeaveReplaceParams({
    required this.employeeId,
    required this.requestDate,
    required this.leaveStartDate,
    required this.leaveEndDate,
    required this.leaveTypeId,
    required this.leaveId,
  });

  Map<String, dynamic> toMap() => {
        'employee_id': employeeId,
        'request_date': requestDate,
        'leave_start_date': leaveStartDate,
        'leave_end_date': leaveEndDate,
        'leave_type_id': leaveTypeId,
        'leave_id': leaveId,
      };

  @override
  List<Object?> get props => [
        employeeId,
        requestDate,
        leaveStartDate,
        leaveEndDate,
        leaveTypeId,
        leaveId,
      ];
}
