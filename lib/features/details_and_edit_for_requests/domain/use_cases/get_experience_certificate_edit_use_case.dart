import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetExperienceCertificateEditUseCase
    extends UseCase<EditResponse, GetExperienceCertificateEditParams> {
  final MyRequestsRepository _repository;

  GetExperienceCertificateEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetExperienceCertificateEditParams params,
  }) async {
    return await _repository.getExperienceCertificateEdit(params: params);
  }
}

class GetExperienceCertificateEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetExperienceCertificateEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, editReasons];
}
