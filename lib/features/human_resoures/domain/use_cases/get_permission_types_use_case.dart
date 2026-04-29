import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entity/permission_type.dart';
import '../repository/repository.dart';

class GetPermissionTypesUseCase extends UseCase<List<PermissionType>, NoParams> {
  final HRServicesRepository _repository;

  GetPermissionTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<PermissionType>>> call({
    required NoParams params,
  }) async {
    return await _repository.getAllPermissionTypes(params: params);
  }
}
