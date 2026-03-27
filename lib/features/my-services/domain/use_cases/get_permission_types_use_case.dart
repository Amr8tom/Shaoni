import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/my-services/domain/entity/permission_type.dart';
import 'package:shaoni/features/my-services/domain/repository/repository.dart';

class GetPermissionTypesUseCase extends UseCase<List<PermissionType>, NoParams> {
  final ServicesRepository _repository;

  GetPermissionTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<PermissionType>>> call({
    required NoParams params,
  }) async {
    return await _repository.getAllPermissionTypes(params: params);
  }
}
