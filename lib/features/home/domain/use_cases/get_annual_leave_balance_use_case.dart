import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import '../entities/annual_leave_balance.dart';
import '../repositories/home_repositories.dart';

class GetAnnualLeaveBalanceUseCase
    extends UseCase<AnnualLeaveBalance, NoParams> {
  final HomeRepositories _repository;

  GetAnnualLeaveBalanceUseCase(this._repository);

  @override
  Future<Either<Failure, AnnualLeaveBalance>> call(
      {required NoParams params}) async {
    return await _repository.getAnnualLeaveBalance();
  }
}
