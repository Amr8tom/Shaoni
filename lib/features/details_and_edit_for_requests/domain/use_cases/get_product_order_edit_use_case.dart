import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetProductOrderEditUseCase
    extends UseCase<EditResponse, GetProductOrderEditParams> {
  final MyRequestsRepository _repository;

  GetProductOrderEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetProductOrderEditParams params,
  }) async {
    return await _repository.getProductOrderEdit(params: params);
  }
}

class GetProductOrderEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetProductOrderEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, editReasons];
}
