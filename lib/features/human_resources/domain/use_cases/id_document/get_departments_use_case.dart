import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/id_document/department.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class GetDepartmentsUseCase extends UseCase<List<Department>, NoParams> {
  final HRServicesRepository _repository;

  GetDepartmentsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Department>>> call({
    required NoParams params,
  }) async {
    return await _repository.getDepartments(params: params);
  }
}
