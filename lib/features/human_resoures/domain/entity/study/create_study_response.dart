import 'package:equatable/equatable.dart';

// Response shape: { "success": true, "message": "...", "requestId": 0, "data": null }
class CreateStudyResponse extends Equatable {
  final bool success;
  final String? message;
  final int requestId;
  final dynamic data;

  const CreateStudyResponse({
    required this.success,
    required this.message,
    required this.requestId,
    required this.data,
  });

  @override
  List<Object?> get props => [success, message, requestId, data];
}
