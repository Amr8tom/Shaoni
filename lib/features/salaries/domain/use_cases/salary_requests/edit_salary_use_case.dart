import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/salary_requests/create_salary_response.dart';
import '../../repository/salaries_repository.dart';

class EditSalaryUseCase {
  final SalariesRepository repository;

  EditSalaryUseCase(this.repository);

  Future<Either<Failure, CreateSalaryResponse>> call({
    required EditSalaryParams params,
  }) async {
    return await repository.editSalaryRequest(params: params);
  }
}

class EditSalaryParams {
  final int requestId;
  final String editReasons;

  const EditSalaryParams({
    required this.requestId,
    required this.editReasons,
  });

  Map<String, dynamic> toMap() {
    return {
      'edit_reasons': editReasons,
    };
  }
}
