import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetAttendanceEditUseCase
    extends UseCase<EditResponse, GetAttendanceEditParams> {
  final MyRequestsRepository _repository;

  GetAttendanceEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetAttendanceEditParams params,
  }) async {
    return await _repository.getAttendanceEdit(params: params);
  }
}

class GetAttendanceEditParams extends Equatable {
  final int requestId;
  final String note;
  final String editReasons;

  const GetAttendanceEditParams({
    required this.requestId,
    required this.note,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'edit_reasons': editReasons,
    };
  }

  @override
  List<Object?> get props => [requestId, note, editReasons];
}
