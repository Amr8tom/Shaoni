import 'package:equatable/equatable.dart';

/// Response of POST /OutsideWorkingLines/action/{odooLineId}
class OutsideWorkingLineActionResponse extends Equatable {
  final String status;
  final String message;
  final int? odooLineId;
  final int? localLineId;
  final String action;
  final String newState;
  final String? cancelReason;

  const OutsideWorkingLineActionResponse({
    this.status = '',
    this.message = '',
    this.odooLineId,
    this.localLineId,
    this.action = '',
    this.newState = '',
    this.cancelReason,
  });

  bool get isSuccess => status.toLowerCase() == 'success';

  @override
  List<Object?> get props => [
        status,
        message,
        odooLineId,
        localLineId,
        action,
        newState,
        cancelReason,
      ];
}
