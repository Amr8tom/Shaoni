import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetLeaveReplaceEditUseCase
    extends UseCase<EditResponse, GetLeaveReplaceEditParams> {
  final MyRequestsRepository _repository;

  GetLeaveReplaceEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetLeaveReplaceEditParams params,
  }) async {
    return await _repository.getLeaveReplaceEdit(params: params);
  }
}

class GetLeaveReplaceEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetLeaveReplaceEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, editReasons];
}
