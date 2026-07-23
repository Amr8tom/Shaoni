import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_employee.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';

/// Employee list for the alternative-employee dropdown.
class GetLeaveEmployeesUseCase extends UseCase<List<LeaveEmployee>, NoParams> {
  final LeavesRepository _repository;

  GetLeaveEmployeesUseCase(this._repository);

  @override
  Future<Either<Failure, List<LeaveEmployee>>> call({
    required NoParams params,
  }) async {
    return await _repository.getLeaveEmployees(params: params);
  }
}
