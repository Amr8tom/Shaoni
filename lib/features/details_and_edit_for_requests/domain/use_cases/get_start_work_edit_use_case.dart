import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetStartWorkEditUseCase
    extends UseCase<EditResponse, GetStartWorkEditParams> {
  final MyRequestsRepository _repository;

  GetStartWorkEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetStartWorkEditParams params,
  }) async {
    return await _repository.getStartWorkEdit(params: params);
  }
}

class GetStartWorkEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetStartWorkEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, editReasons];
}
