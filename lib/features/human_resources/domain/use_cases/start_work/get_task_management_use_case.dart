import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/start_work/start_work_option.dart';
import '../../repository/repository.dart';

class GetTaskManagementUseCase
    extends UseCase<List<StartWorkOption>, NoParams> {
  final HRServicesRepository _repository;

  GetTaskManagementUseCase(this._repository);

  @override
  Future<Either<Failure, List<StartWorkOption>>> call({
    required NoParams params,
  }) async {
    return await _repository.getTaskManagement(params: params);
  }
}
