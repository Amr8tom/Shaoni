import 'package:shaoni/features/human_resources/domain/entity/attendance/attendance.dart';

class AttendanceModel extends Attendance {
  AttendanceModel(
      {required super.success,
      required super.message,
      required super.requestNumber});

  /// fromJson
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      requestNumber: json['attendanceName'] ?? '',
    );
  }

  /// to Map
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'attendanceName': requestNumber,
    };
  }
}
