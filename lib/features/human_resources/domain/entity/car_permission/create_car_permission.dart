import 'package:equatable/equatable.dart';

// {
// "success": false,
// "message": "رقم السيارة له تصريح سابق",
// "requestId": 0,
// "data": null
// }

class CreateCarPermission extends Equatable {
  final bool success;
  final String? message;
  final int requestId;
  final dynamic data;

  const CreateCarPermission({
    required this.success,
    required this.message,
    required this.requestId,
    required this.data,
  });


  @override
  List<Object?> get props => [success, message, requestId, data];
}
