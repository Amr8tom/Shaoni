import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_employee.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class GetOutsideWorkingEmployeesUseCase
    extends UseCase<List<OutsideWorkingEmployee>, NoParams> {
  final HRServicesRepository _repository;

  GetOutsideWorkingEmployeesUseCase(this._repository);

  @override
  Future<Either<Failure, List<OutsideWorkingEmployee>>> call(
      {required NoParams params}) async {
    return await _repository.getOutsideWorkingEmployees(params: params);
  }
}
