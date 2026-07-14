import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_replace/create_leave_replace_response.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_replace/create_leave_replace_use_case.dart';

class UpdateLeaveReplaceUseCase
    extends UseCase<CreateLeaveReplaceResponse, UpdateLeaveReplaceParams> {
  final LeavesRepository _repository;

  UpdateLeaveReplaceUseCase(this._repository);

  @override
  Future<Either<Failure, CreateLeaveReplaceResponse>> call({
    required UpdateLeaveReplaceParams params,
  }) async {
    return await _repository.updateLeaveReplace(params: params);
  }
}

class UpdateLeaveReplaceParams extends Equatable {
  final int requestId;
  final CreateLeaveReplaceParams data;
  final String editReasons;
  final String rejectReasons;

  const UpdateLeaveReplaceParams({
    required this.requestId,
    required this.data,
    this.editReasons = '',
    this.rejectReasons = '',
  });

  Map<String, dynamic> toMap() => {
        ...data.toMap(),
        'edit_reasons': editReasons,
        'reject_reasons': rejectReasons,
      };

  @override
  List<Object?> get props => [requestId, data, editReasons, rejectReasons];
}
