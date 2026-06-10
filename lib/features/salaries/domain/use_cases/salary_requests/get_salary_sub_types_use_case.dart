import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/salary_requests/salary_sub_type.dart';
import '../../repository/salaries_repository.dart';

class GetSalarySubTypesUseCase {
  final SalariesRepository repository;

  GetSalarySubTypesUseCase(this.repository);

  Future<Either<Failure, List<SalarySubType>>> call() async {
    return await repository.getSalarySubTypes();
  }
}
