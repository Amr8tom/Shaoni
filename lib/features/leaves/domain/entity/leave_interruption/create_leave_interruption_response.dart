import 'package:equatable/equatable.dart';

/// Domain entity for the response of
/// POST /LeaveInterruption
class CreateLeaveInterruptionResponse extends Equatable {
  final bool success;
  final String message;
  final int? requestId;
  final String requestName;

  const CreateLeaveInterruptionResponse({
    this.success = false,
    this.message = '',
    this.requestId,
    this.requestName = '',
  });

  @override
  List<Object?> get props => [success, message, requestId, requestName];
}
