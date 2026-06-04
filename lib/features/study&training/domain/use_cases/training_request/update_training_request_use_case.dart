import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entities/training_request/create_training_response.dart';
import '../../repository/repository.dart';
import 'create_training_request_use_case.dart';

class UpdateTrainingRequestUseCase
    extends UseCase<CreateTrainingResponse, UpdateTrainingRequestParams> {
  final StudyServicesRepository _repository;

  UpdateTrainingRequestUseCase(this._repository);

  @override
  Future<Either<Failure, CreateTrainingResponse>> call({
    required UpdateTrainingRequestParams params,
  }) async {
    return await _repository.updateTrainingRequest(params: params);
  }
}

class UpdateTrainingRequestParams extends Equatable {
  final int requestId;
  final CreateTrainingRequestParams data;

  const UpdateTrainingRequestParams({
    required this.requestId,
    required this.data,
  });

  @override
  List<Object?> get props => [requestId, data];
}
