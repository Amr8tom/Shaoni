import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/loan/loan_type.dart';
import '../../repository/salaries_repository.dart';

class GetLoanTypesUseCase {
  final SalariesRepository repository;

  GetLoanTypesUseCase(this.repository);

  Future<Either<Failure, List<LoanType>>> call() async {
    return await repository.getLoanTypes();
  }
}
