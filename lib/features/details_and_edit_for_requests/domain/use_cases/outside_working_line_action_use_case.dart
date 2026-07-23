import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/outside_working_line_action_response.dart';
import '../repositories/repository.dart';

/// Employee accept / refuse on a single outside-working assignment line.
class OutsideWorkingLineActionUseCase extends UseCase<
    OutsideWorkingLineActionResponse, OutsideWorkingLineActionParams> {
  final MyRequestsRepository _repository;

  OutsideWorkingLineActionUseCase(this._repository);

  @override
  Future<Either<Failure, OutsideWorkingLineActionResponse>> call({
    required OutsideWorkingLineActionParams params,
  }) async {
    return await _repository.outsideWorkingLineAction(params: params);
  }
}

enum OutsideWorkingLineAction {
  approveEmployee('approve_employee'),
  disapproveEmployee('disapprove_employee'),
  approveManager('approve_manager'),
  disapproveManager('disapprove_manager');

  final String code;

  const OutsideWorkingLineAction(this.code);

  bool get isDisapprove =>
      this == OutsideWorkingLineAction.disapproveEmployee ||
      this == OutsideWorkingLineAction.disapproveManager;
}

class OutsideWorkingLineActionParams extends Equatable {
  /// The line's `odooLineId` — used as the path segment.
  final int lineId;
  final OutsideWorkingLineAction action;
  final String cancelReason;

  const OutsideWorkingLineActionParams({
    required this.lineId,
    required this.action,
    this.cancelReason = '',
  });

  Map<String, dynamic> toMap() => {
        'action': action.code,
        // Only sent when refusing — approve takes no reason.
        if (action.isDisapprove) 'cancel_reason': cancelReason,
      };

  @override
  List<Object?> get props => [lineId, action, cancelReason];
}
