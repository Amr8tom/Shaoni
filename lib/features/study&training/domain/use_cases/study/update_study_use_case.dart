import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import '../../entities/study/create_study_response.dart';
import '../../repository/repository.dart';
import 'create_study_use_case.dart';

class UpdateStudyUseCase extends UseCase<CreateStudyResponse, UpdateStudyParams> {
  final StudyServicesRepository repository;

  UpdateStudyUseCase(this.repository);

  @override
  Future<Either<Failure, CreateStudyResponse>> call({
    required UpdateStudyParams params,
  }) async {
    return await repository.updateStudyRequest(params: params);
  }
}

class UpdateStudyParams {
  final int requestId;
  final CreateStudyParams data;

  const UpdateStudyParams({
    required this.requestId,
    required this.data,
  });

  Map<String, dynamic> toMap() => data.toMap();
}
