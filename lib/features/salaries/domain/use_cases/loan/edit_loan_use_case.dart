import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/loan/create_loan_response.dart';
import '../../repository/salaries_repository.dart';

class EditLoanUseCase {
  final SalariesRepository repository;

  EditLoanUseCase(this.repository);

  Future<Either<Failure, CreateLoanResponse>> call({
    required EditLoanParams params,
  }) async {
    return await repository.editLoanRequest(params: params);
  }
}

class EditLoanParams {
  final int requestId;
  final String editReasons;

  const EditLoanParams({
    required this.requestId,
    required this.editReasons,
  });

  Map<String, dynamic> toMap() {
    return {
      'edit_reasons': editReasons,
    };
  }
}
