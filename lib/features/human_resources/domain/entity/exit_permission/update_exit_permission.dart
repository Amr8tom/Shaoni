import 'package:equatable/equatable.dart';

class UpdateExitPermission extends Equatable {
  final bool success;
  final String message;
  final int requestId;
  final dynamic data;

  const UpdateExitPermission({
    required this.success,
    required this.message,
    required this.requestId,
    required this.data,
  });

  @override
  List<Object?> get props => [success, message, requestId, data];
}
