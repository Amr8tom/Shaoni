import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/start_work/start_work_type.dart';
import '../../repository/repository.dart';

class GetStartWorkTypesUseCase extends UseCase<List<StartWorkType>, NoParams> {
  final HRServicesRepository _repository;

  GetStartWorkTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<StartWorkType>>> call({
    required NoParams params,
  }) async {
    return await _repository.getStartWorkTypes(params: params);
  }
}
