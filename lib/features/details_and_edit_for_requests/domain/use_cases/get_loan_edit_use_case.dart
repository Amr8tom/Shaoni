import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetLoanEditUseCase extends UseCase<EditResponse, GetLoanEditParams> {
  final MyRequestsRepository _repository;

  GetLoanEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetLoanEditParams params,
  }) async {
    return await _repository.getLoanEdit(params: params);
  }
}

class GetLoanEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetLoanEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, editReasons];
}
