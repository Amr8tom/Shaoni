import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_appointment.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';

/// Read-only list of the employee's previously-booked leaves.
class GetLeaveAppointmentsUseCase
    extends UseCase<List<LeaveAppointment>, GetLeaveAppointmentsParams> {
  final LeavesRepository _repository;

  GetLeaveAppointmentsUseCase(this._repository);

  @override
  Future<Either<Failure, List<LeaveAppointment>>> call({
    required GetLeaveAppointmentsParams params,
  }) async {
    return await _repository.getLeaveAppointments(params: params);
  }
}

class GetLeaveAppointmentsParams extends Equatable {
  final int employeeId;

  const GetLeaveAppointmentsParams({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}
