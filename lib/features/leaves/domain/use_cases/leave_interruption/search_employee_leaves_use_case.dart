import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/employee_leave.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';

class SearchEmployeeLeavesUseCase
    extends UseCase<List<EmployeeLeave>, SearchEmployeeLeavesParams> {
  final LeavesRepository _repository;

  SearchEmployeeLeavesUseCase(this._repository);

  @override
  Future<Either<Failure, List<EmployeeLeave>>> call({
    required SearchEmployeeLeavesParams params,
  }) async {
    return await _repository.searchEmployeeLeaves(params: params);
  }
}

class SearchEmployeeLeavesParams extends Equatable {
  final int leaveTypeId;

  const SearchEmployeeLeavesParams({required this.leaveTypeId});

  @override
  List<Object?> get props => [leaveTypeId];
}
