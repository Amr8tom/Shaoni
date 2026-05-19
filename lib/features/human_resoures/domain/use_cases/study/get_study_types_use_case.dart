import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/study/study_type.dart';
import '../../repository/repository.dart';

class GetStudyTypesUseCase extends UseCase<List<StudyType>, NoParams> {
  final HRServicesRepository _repository;

  GetStudyTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<StudyType>>> call({
    required NoParams params,
  }) async {
    return await _repository.getStudyTypes(params: params);
  }
}
