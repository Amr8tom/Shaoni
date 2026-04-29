import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/all_services.dart';

import '../repository/repository.dart';

class GetAllPermissionServicesUseCase extends UseCase<AllServices, NoParams> {
  final HRServicesRepository _repository;

  GetAllPermissionServicesUseCase(this._repository);

  @override
  Future<Either<Failure, AllServices>> call({required NoParams params}) async {
    return await _repository.getAllPermissionServices(params: params);
  }
}
