import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/leave_type.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';

class GetLeaveTypesUseCase extends UseCase<List<LeaveType>, NoParams> {
  final LeavesRepository _repository;

  GetLeaveTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<LeaveType>>> call({
    required NoParams params,
  }) async {
    return await _repository.getLeaveTypes(params: params);
  }
}
