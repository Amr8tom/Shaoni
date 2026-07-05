import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetLeaveInterruptionEditUseCase
    extends UseCase<EditResponse, GetLeaveInterruptionEditParams> {
  final MyRequestsRepository _repository;

  GetLeaveInterruptionEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetLeaveInterruptionEditParams params,
  }) async {
    return await _repository.getLeaveInterruptionEdit(params: params);
  }
}

class GetLeaveInterruptionEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetLeaveInterruptionEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, editReasons];
}
