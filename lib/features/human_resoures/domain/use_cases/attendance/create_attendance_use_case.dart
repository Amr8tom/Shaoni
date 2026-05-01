import 'package:shaoni/core/utils/usecases/base_usecase.dart';

// class CreateAttendanceUseCase extends UseCase{}

// {
// "employee":           123,
// "attendance_type":    "check_in",
// "update_Date":        "2026-01-26 08:15",
// "date":               "2026-01-26",
// "attendance_id":      456,
// "order_reason":       "نسيت تسجيل الحضور",
// "forget_reasons_ids": 1,
// "request_attachment_ids": [
// {
// "name": "Supporting Document",
// "attachment_ids": [
// { "name": "receipt.jpg", "attachment": "<base64 string>" }
// ]
// }
// ],
// "fields": [
// "id", "name", "order_date", "registration_number",
// "attendance_type", "update_date", "order_reason",
// "stage_id", "employee", "department_id", "office_id",
// "resource_calendar_id", "forget_reasons_ids",
// "attendance_id", "request_attachment_ids"
// ]
// }

class CreateAttendanceParams {
  final int employee;
  final String attendanceType;
  final String updateDate;
  final String date;
  final int attendanceId;
  final String orderReason;
  final int forgetReasonsIds;

  // final List<RequestAttachmentIds> requestAttachmentIds;

  CreateAttendanceParams({
    required this.employee,
    required this.attendanceType,
    required this.updateDate,
    required this.date,
    required this.attendanceId,
    required this.orderReason,
    required this.forgetReasonsIds,
    // required this.requestAttachmentIds,
  });

  /// toMap
  Map<String, dynamic> toMap() {
    return {
      "employee": this.employee,
      "attendance_type": this.attendanceType,
      "update_Date": this.updateDate,
      "date": this.date,
      "attendance_id": this.attendanceId,
      "order_reason": this.orderReason,
      "forget_reasons_ids": this.forgetReasonsIds,
      // "request_attachment_ids": this.requestAttachmentIds.map((e) => e.toMap()).toList(),
      "fields": [
        "id",
        "name",
        "order_date",
        "registration_number",
        "attendance_type",
        "update_date",
        "order_reason",
        "stage_id",
        "employee",
        "department_id",
        "office_id",
        "resource_calendar_id",
        "forget_reasons_ids",
        "attendance_id",
        "request_attachment_ids"
      ]
    };
  }
}
