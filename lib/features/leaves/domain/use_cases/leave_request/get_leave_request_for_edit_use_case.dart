import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_request_edit_data.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';

/// Fetches an existing hr.leave request to prefill the edit form.
class GetLeaveRequestForEditUseCase
    extends UseCase<LeaveRequestEditData, GetLeaveRequestForEditParams> {
  final LeavesRepository _repository;

  GetLeaveRequestForEditUseCase(this._repository);

  @override
  Future<Either<Failure, LeaveRequestEditData>> call({
    required GetLeaveRequestForEditParams params,
  }) async {
    return await _repository.getLeaveRequestForEdit(params: params);
  }
}

class GetLeaveRequestForEditParams extends Equatable {
  final int requestId;

  const GetLeaveRequestForEditParams({required this.requestId});

  @override
  List<Object?> get props => [requestId];
}
