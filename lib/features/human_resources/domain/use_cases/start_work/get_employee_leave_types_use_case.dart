import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/start_work/employee_leave_type.dart';
import '../../repository/repository.dart';

class GetEmployeeLeaveTypesUseCase
    extends UseCase<List<EmployeeLeaveType>, GetEmployeeLeaveTypesParams> {
  final HRServicesRepository _repository;

  GetEmployeeLeaveTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<EmployeeLeaveType>>> call({
    required GetEmployeeLeaveTypesParams params,
  }) async {
    return await _repository.getEmployeeLeaveTypes(params: params);
  }
}

class GetEmployeeLeaveTypesParams extends Equatable {
  final int employeeId;

  const GetEmployeeLeaveTypesParams({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}
