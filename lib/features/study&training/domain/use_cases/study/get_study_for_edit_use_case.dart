import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/study&training/domain/entities/study/study_edit_data.dart';
import 'package:shaoni/features/study&training/domain/repository/repository.dart';

/// Fetches an existing study request to prefill the edit form.
class GetStudyForEditUseCase
    extends UseCase<StudyEditData, GetStudyForEditParams> {
  final StudyServicesRepository _repository;

  GetStudyForEditUseCase(this._repository);

  @override
  Future<Either<Failure, StudyEditData>> call({
    required GetStudyForEditParams params,
  }) async {
    return await _repository.getStudyForEdit(params: params);
  }
}

class GetStudyForEditParams extends Equatable {
  final int requestId;

  const GetStudyForEditParams({required this.requestId});

  @override
  List<Object?> get props => [requestId];
}
