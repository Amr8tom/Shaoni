import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/salary_requests/country.dart';
import '../../repository/salaries_repository.dart';

class GetCountriesUseCase {
  final SalariesRepository repository;

  GetCountriesUseCase(this.repository);

  Future<Either<Failure, List<Country>>> call() async {
    return await repository.getCountries();
  }
}
