import 'package:equatable/equatable.dart';

/// Domain entity for the response of
/// POST /LeaveReplace
class CreateLeaveReplaceResponse extends Equatable {
  final bool success;
  final String message;
  final int? requestId;
  final String requestName;

  const CreateLeaveReplaceResponse({
    this.success = false,
    this.message = '',
    this.requestId,
    this.requestName = '',
  });

  @override
  List<Object?> get props => [success, message, requestId, requestName];
}
