import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/interruption_type.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';

class GetInterruptionTypesUseCase
    extends UseCase<List<InterruptionType>, NoParams> {
  final LeavesRepository _repository;

  GetInterruptionTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<InterruptionType>>> call({
    required NoParams params,
  }) async {
    return await _repository.getInterruptionTypes(params: params);
  }
}
