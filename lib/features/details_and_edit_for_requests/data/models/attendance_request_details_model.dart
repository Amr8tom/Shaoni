import '../../domain/entities/attendance/attendance_request_details.dart';

class AttendanceRequestDetailsModel extends AttendanceRequestDetails {
  AttendanceRequestDetailsModel(
      {required super.id,
      required super.attendanceId,
      required super.orderReason,
      required super.notes,
      required super.attendanceType,
      required super.forgetReason,
      required super.missingAttendance});
  /// fromJson
  factory AttendanceRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRequestDetailsModel(
      id: json['id'],
      attendanceId: json['attendanceId'],
      orderReason: json['orderReason'],
      notes: json['notes'],
      attendanceType: json['attendanceType'],
      forgetReason: json['forgetReason'],
      missingAttendance: json['missingAttendance'],
    );
  }
  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attendanceId': attendanceId,
      'orderReason': orderReason,
      'notes': notes,
      'attendanceType': attendanceType,
      'forgetReason': forgetReason,
      'missingAttendance': missingAttendance,
    };
  }
}
