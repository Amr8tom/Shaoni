import 'package:equatable/equatable.dart';

/// Response shape: { "success": true, "message": "...", "requestId": 0 }
class CreateStartWorkResponse extends Equatable {
  final bool success;
  final String? message;
  final int requestId;

  const CreateStartWorkResponse({
    required this.success,
    required this.message,
    required this.requestId,
  });

  @override
  List<Object?> get props => [success, message, requestId];
}
