import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/car_permission/car_brand.dart';
import '../../repository/repository.dart';

class GetCarBrandsUseCase extends UseCase<List<CarBrand>, NoParams> {
  final HRServicesRepository _repository;

  GetCarBrandsUseCase(this._repository);

  @override
  Future<Either<Failure, List<CarBrand>>> call({
    required NoParams params,
  }) async {
    return await _repository.getCarBrands(params: params);
  }
}
