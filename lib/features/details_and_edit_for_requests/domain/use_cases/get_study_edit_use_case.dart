import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetStudyEditUseCase extends UseCase<EditResponse, GetStudyEditParams> {
  final MyRequestsRepository _repository;

  GetStudyEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetStudyEditParams params,
  }) async {
    return await _repository.getStudyEdit(params: params);
  }
}

class GetStudyEditParams extends Equatable {
  final int requestId;
  final String note;
  final String editReasons;

  const GetStudyEditParams({
    required this.requestId,
    required this.note,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'note': note,
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, note, editReasons];
}
