import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/my-services/domain/entity/permission_time.dart';
import 'package:shaoni/features/my-services/domain/repository/repository.dart';

class GetPermissionTimeUseCase extends UseCase<List<PermissionTime>, NoParams> {
  final ServicesRepository _repository;

  GetPermissionTimeUseCase(this._repository);

  @override
  Future<Either<Failure, List<PermissionTime>>> call({
    required NoParams params,
  }) async {
    return await _repository.getAllPermissionTimes(params: params);
  }
}
