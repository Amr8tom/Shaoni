import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/study&training/domain/entities/training_request/training_edit_data.dart';
import 'package:shaoni/features/study&training/domain/repository/repository.dart';

/// Fetches an existing training request to prefill the edit form.
class GetTrainingForEditUseCase
    extends UseCase<TrainingEditData, GetTrainingForEditParams> {
  final StudyServicesRepository _repository;

  GetTrainingForEditUseCase(this._repository);

  @override
  Future<Either<Failure, TrainingEditData>> call({
    required GetTrainingForEditParams params,
  }) async {
    return await _repository.getTrainingForEdit(params: params);
  }
}

class GetTrainingForEditParams extends Equatable {
  final int requestId;

  const GetTrainingForEditParams({required this.requestId});

  @override
  List<Object?> get props => [requestId];
}
