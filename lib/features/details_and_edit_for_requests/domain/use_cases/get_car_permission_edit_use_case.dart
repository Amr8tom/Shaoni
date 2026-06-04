import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetCarPermissionEditUseCase
    extends UseCase<EditResponse, GetCarPermissionEditParams> {
  final MyRequestsRepository _repository;

  GetCarPermissionEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetCarPermissionEditParams params,
  }) async {
    return await _repository.getCarPermissionEdit(params: params);
  }
}

class GetCarPermissionEditParams extends Equatable {
  final int requestId;
  final String notes;
  final String editReasons;

  const GetCarPermissionEditParams({
    required this.requestId,
    required this.notes,
    required this.editReasons,
  });

  Map<String, dynamic> toMap() {
    return {
      'notes': notes,
      'edit_reasons': editReasons,
    };
  }

  @override
  List<Object?> get props => [requestId, notes, editReasons];
}
