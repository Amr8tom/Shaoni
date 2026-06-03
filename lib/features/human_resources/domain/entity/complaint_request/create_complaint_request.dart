import 'package:equatable/equatable.dart';

// {
//   "success": true,
//   "message": "تم إرسال الشكوى بنجاح",
//   "requestId": 0,
//   "data": null
// }

class CreateComplaintRequest extends Equatable {
  final bool success;
  final String? message;
  final int requestId;
  final dynamic data;

  const CreateComplaintRequest({
    required this.success,
    required this.message,
    required this.requestId,
    required this.data,
  });

  @override
  List<Object?> get props => [success, message, requestId, data];
}
