import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/loan/create_loan_response.dart';
import '../../repository/salaries_repository.dart';
import 'create_loan_use_case.dart';

class UpdateLoanUseCase {
  final SalariesRepository repository;

  UpdateLoanUseCase(this.repository);

  Future<Either<Failure, CreateLoanResponse>> call({
    required UpdateLoanParams params,
  }) async {
    return await repository.updateLoanRequest(params: params);
  }
}

class UpdateLoanParams {
  final int requestId;
  final CreateLoanParams createParams;

  const UpdateLoanParams({
    required this.requestId,
    required this.createParams,
  });

  Map<String, dynamic> toMap() => createParams.toMap();
}
