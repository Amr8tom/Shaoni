import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/salary_requests/bank.dart';
import '../../repository/salaries_repository.dart';

class GetBanksUseCase {
  final SalariesRepository repository;

  GetBanksUseCase(this.repository);

  Future<Either<Failure, List<Bank>>> call(
      {required GetBanksParams params}) async {
    return await repository.getBanks(params: params);
  }
}

class GetBanksParams {
  final int countryId;

  const GetBanksParams({required this.countryId});
}
