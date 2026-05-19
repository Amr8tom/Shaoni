import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetExitPermissionEditUseCase
    extends UseCase<EditResponse, GetExitPermissionEditParams> {
  final MyRequestsRepository _repository;

  GetExitPermissionEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetExitPermissionEditParams params,
  }) async {
    return await _repository.getExitPermissionEdit(params: params);
  }
}

class GetExitPermissionEditParams extends Equatable {
  final int requestId;
  final String notes;
  final String editReasons;
  final String rejectReasons;
  final List<String> fields;

  const GetExitPermissionEditParams({
    required this.requestId,
    required this.notes,
    this.editReasons = '',
    this.rejectReasons = '',
    this.fields = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'notes': notes,
      'edit_reasons': editReasons,
    };
  }

  @override
  List<Object?> get props =>
      [requestId, notes, editReasons, rejectReasons, fields];
}
