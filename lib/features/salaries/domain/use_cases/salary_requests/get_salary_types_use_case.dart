import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/salary_requests/salary_type.dart';
import '../../repository/salaries_repository.dart';

class GetSalaryTypesUseCase {
  final SalariesRepository repository;

  GetSalaryTypesUseCase(this.repository);

  Future<Either<Failure, List<SalaryType>>> call() async {
    return await repository.getSalaryTypes();
  }
}
