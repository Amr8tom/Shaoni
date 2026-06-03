import 'package:shaoni/features/human_resources/domain/entity/attendance/update_attendance.dart';

class UpdateAttendanceModel extends UpdateAttendance {
  const UpdateAttendanceModel({
    required super.success,
    required super.message,
    required super.requestId,
    required super.data,
  });

  factory UpdateAttendanceModel.fromJson(Map<String, dynamic> json) {
    return UpdateAttendanceModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      requestId: json['requestId'] ?? 0,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'requestId': requestId,
      'data': data,
    };
  }
}
