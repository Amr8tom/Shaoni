import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/create_leave_interruption_response.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/create_leave_interruption_use_case.dart';

class UpdateLeaveInterruptionUseCase extends UseCase<
    CreateLeaveInterruptionResponse, UpdateLeaveInterruptionParams> {
  final LeavesRepository _repository;

  UpdateLeaveInterruptionUseCase(this._repository);

  @override
  Future<Either<Failure, CreateLeaveInterruptionResponse>> call({
    required UpdateLeaveInterruptionParams params,
  }) async {
    return await _repository.updateLeaveInterruption(params: params);
  }
}

class UpdateLeaveInterruptionParams extends Equatable {
  final int requestId;
  final CreateLeaveInterruptionParams data;

  const UpdateLeaveInterruptionParams({
    required this.requestId,
    required this.data,
  });

  @override
  List<Object?> get props => [requestId, data];
}
