import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetOutsideWorkingEditUseCase
    extends UseCase<EditResponse, GetOutsideWorkingEditParams> {
  final MyRequestsRepository _repository;

  GetOutsideWorkingEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetOutsideWorkingEditParams params,
  }) async {
    return await _repository.getOutsideWorkingEdit(params: params);
  }
}

class GetOutsideWorkingEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetOutsideWorkingEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, editReasons];
}
