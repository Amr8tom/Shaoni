import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/salary_requests/create_salary_response.dart';
import '../../repository/salaries_repository.dart';
import 'create_salary_use_case.dart';

class UpdateSalaryUseCase {
  final SalariesRepository repository;

  UpdateSalaryUseCase(this.repository);

  Future<Either<Failure, CreateSalaryResponse>> call({
    required UpdateSalaryParams params,
  }) async {
    return await repository.updateSalaryRequest(params: params);
  }
}

class UpdateSalaryParams {
  final int requestId;
  final CreateSalaryParams createParams;

  const UpdateSalaryParams({
    required this.requestId,
    required this.createParams,
  });

  Map<String, dynamic> toMap() {
    return createParams.toMap();
  }
}
