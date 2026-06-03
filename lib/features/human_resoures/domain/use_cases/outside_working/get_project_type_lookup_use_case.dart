import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/outside_working/project_type_lookup.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class GetProjectTypeLookupUseCase extends UseCase<List<ProjectTypeLookup>, NoParams> {
  final HRServicesRepository _repository;

  GetProjectTypeLookupUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProjectTypeLookup>>> call({required NoParams params}) async {
    return await _repository.getProjectTypeLookup(params: params);
  }
}
