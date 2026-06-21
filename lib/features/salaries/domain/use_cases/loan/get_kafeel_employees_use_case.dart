import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/loan/kafeel_employee.dart';
import '../../repository/salaries_repository.dart';

class GetKafeelEmployeesUseCase {
  final SalariesRepository repository;

  GetKafeelEmployeesUseCase(this.repository);

  Future<Either<Failure, List<KafeelEmployee>>> call() async {
    return await repository.getKafeelEmployees();
  }
}
