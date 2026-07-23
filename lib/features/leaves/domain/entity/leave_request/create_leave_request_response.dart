import 'package:equatable/equatable.dart';

/// Response of POST /hr_leave/create and PUT /hr_leave/update/{id}.
/// Both return `{code, message, count, body:{ id, sequence_number, ... }}`.
class CreateLeaveRequestResponse extends Equatable {
  final bool success;
  final String message;
  final int? requestId;
  final String requestName;

  const CreateLeaveRequestResponse({
    this.success = false,
    this.message = '',
    this.requestId,
    this.requestName = '',
  });

  @override
  List<Object?> get props => [success, message, requestId, requestName];
}
