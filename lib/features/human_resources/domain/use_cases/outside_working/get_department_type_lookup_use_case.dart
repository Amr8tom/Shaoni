import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/department_type_lookup.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class GetDepartmentTypeLookupUseCase extends UseCase<List<DepartmentTypeLookup>, NoParams> {
  final HRServicesRepository _repository;

  GetDepartmentTypeLookupUseCase(this._repository);

  @override
  Future<Either<Failure, List<DepartmentTypeLookup>>> call({required NoParams params}) async {
    return await _repository.getDepartmentTypeLookup(params: params);
  }
}
