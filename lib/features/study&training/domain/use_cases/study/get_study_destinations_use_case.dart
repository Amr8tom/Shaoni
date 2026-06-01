import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entities/study/study_destination.dart';
import '../../repository/repository.dart';

class GetStudyDestinationsUseCase
    extends UseCase<List<StudyDestination>, NoParams> {
  final StudyServicesRepository _repository;

  GetStudyDestinationsUseCase(this._repository);

  @override
  Future<Either<Failure, List<StudyDestination>>> call({
    required NoParams params,
  }) async {
    return await _repository.getStudyDestinations(params: params);
  }
}
