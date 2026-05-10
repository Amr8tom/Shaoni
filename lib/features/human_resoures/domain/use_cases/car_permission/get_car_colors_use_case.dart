import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/car_permission/car_color.dart';
import '../../repository/repository.dart';

class GetCarColorsUseCase extends UseCase<List<CarColor>, NoParams> {
  final HRServicesRepository _repository;

  GetCarColorsUseCase(this._repository);

  @override
  Future<Either<Failure, List<CarColor>>> call({
    required NoParams params,
  }) async {
    return await _repository.getCarColors(params: params);
  }
}
