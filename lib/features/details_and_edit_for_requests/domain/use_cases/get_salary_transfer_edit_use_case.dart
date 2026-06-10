import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetSalaryTransferEditUseCase
    extends UseCase<EditResponse, GetSalaryTransferEditParams> {
  final MyRequestsRepository _repository;

  GetSalaryTransferEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetSalaryTransferEditParams params,
  }) async {
    return await _repository.getSalaryTransferEdit(params: params);
  }
}

class GetSalaryTransferEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetSalaryTransferEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'edit_reasons': editReasons,
    };
  }

  @override
  List<Object?> get props => [requestId, editReasons];
}
