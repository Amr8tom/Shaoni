class AttendanceRequestDetails {
  final int id;
  final int attendanceId;
  final String? orderReason;
  final String? notes;
  final String? attendanceType;
  final String? forgetReason;
  final String? missingAttendance;

  AttendanceRequestDetails({
    required this.id,
    required this.attendanceId,
    required this.orderReason,
    required this.notes,
    required this.attendanceType,
    required this.forgetReason,
    required this.missingAttendance,
  });
}
