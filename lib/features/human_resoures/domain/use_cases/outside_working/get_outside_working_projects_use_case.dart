import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/outside_working/outside_working_project.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class GetOutsideWorkingProjectsUseCase extends UseCase<List<OutsideWorkingProject>, NoParams> {
  final HRServicesRepository _repository;

  GetOutsideWorkingProjectsUseCase(this._repository);

  @override
  Future<Either<Failure, List<OutsideWorkingProject>>> call({required NoParams params}) async {
    return await _repository.getOutsideWorkingProjects(params: params);
  }
}
