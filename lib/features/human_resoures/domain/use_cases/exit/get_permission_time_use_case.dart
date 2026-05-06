import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import '../../entity/permission_time.dart';
import '../../repository/repository.dart';

class GetPermissionTimeUseCase extends UseCase<List<PermissionTime>, NoParams> {
  final HRServicesRepository _repository;

  GetPermissionTimeUseCase(this._repository);

  @override
  Future<Either<Failure, List<PermissionTime>>> call({
    required NoParams params,
  }) async {
    return await _repository.getAllPermissionTimes(params: params);
  }
}
