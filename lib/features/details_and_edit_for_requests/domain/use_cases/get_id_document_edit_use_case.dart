import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetIDDocumentEditUseCase
    extends UseCase<EditResponse, GetIDDocumentEditParams> {
  final MyRequestsRepository _repository;

  GetIDDocumentEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetIDDocumentEditParams params,
  }) async {
    return await _repository.getIDDocumentEdit(params: params);
  }
}

class GetIDDocumentEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetIDDocumentEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, editReasons];
}
