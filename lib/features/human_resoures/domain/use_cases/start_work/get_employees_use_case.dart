import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/start_work/employee.dart';
import '../../repository/repository.dart';

class GetEmployeesUseCase extends UseCase<List<Employee>, NoParams> {
  final HRServicesRepository _repository;

  GetEmployeesUseCase(this._repository);

  @override
  Future<Either<Failure, List<Employee>>> call({
    required NoParams params,
  }) async {
    return await _repository.getEmployees(params: params);
  }
}
