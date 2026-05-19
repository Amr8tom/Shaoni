import 'package:equatable/equatable.dart';

// Unified response shape for ALL edit services:
// {
//   "success": true,
//   "message": "...",
//   "requestId": 84,
//   "data": {
//     "success": true, "status": "success", "code": "200", "message": "...",
//     "id": 115, "name": "AU000117", ..., "body": { ...nested... }
//   }
// }

class EditResponse extends Equatable {
  final bool? success;
  final String? message;
  final int? requestId;
  final Map<String, dynamic>? data;

  const EditResponse({
    this.success,
    this.message,
    this.requestId,
    this.data,
  });

  @override
  List<Object?> get props => [success, message, requestId, data];
}
