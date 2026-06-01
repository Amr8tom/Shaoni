import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/id_document/country.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class GetCountriesUseCase extends UseCase<List<Country>, NoParams> {
  final HRServicesRepository _repository;

  GetCountriesUseCase(this._repository);

  @override
  Future<Either<Failure, List<Country>>> call({required NoParams params}) async {
    return await _repository.getCountries(params: params);
  }
}
