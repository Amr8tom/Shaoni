import 'package:equatable/equatable.dart';

// {
//   "success": true,
//   "message": "تم تعديل تصريح السيارة بنجاح",
//   "requestId": 0,
//   "data": null
// }

class UpdateCarPermission extends Equatable {
  final bool success;
  final String? message;
  final int requestId;
  final dynamic data;

  const UpdateCarPermission({
    required this.success,
    required this.message,
    required this.requestId,
    required this.data,
  });

  @override
  List<Object?> get props => [success, message, requestId, data];
}
