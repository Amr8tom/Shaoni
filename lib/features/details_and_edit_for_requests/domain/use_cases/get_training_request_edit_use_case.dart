import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetTrainingRequestEditUseCase
    extends UseCase<EditResponse, GetTrainingRequestEditParams> {
  final MyRequestsRepository _repository;

  GetTrainingRequestEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetTrainingRequestEditParams params,
  }) async {
    return await _repository.getTrainingRequestEdit(params: params);
  }
}

class GetTrainingRequestEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetTrainingRequestEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, editReasons];
}
