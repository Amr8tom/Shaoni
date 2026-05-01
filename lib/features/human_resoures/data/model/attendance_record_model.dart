import 'package:shaoni/features/human_resoures/domain/entity/attendance_record.dart';

import '../../../../generated/l10n.dart';



//

class AttendanceRecordModel extends AttendanceRecord {
  const AttendanceRecordModel(
      {required super.id,
      required super.employeeId,
      required super.employeeName,
      required super.gregorianDate,
      required super.hijriDate,
      required super.checkInTime,
      required super.isCheckedIn,
      required super.checkOutTime,
      required super.isCheckedOut,
      required super.outMode
      });

// {
// "id":                          1,
// "odooId":                      456,
// "employeeId":                  123,
// "employeeName":                "محمد علي",
// "displayName":                 "Attendance 2026-01-26",
// "checkDate":                   "2026-01-26",
// "checkIn":                     "2026-01-26 07:30:00",
// "checkOut":                    null,
// "inMode":                      "manual",
// "outMode":                     null,
// "hijriCheckInDisplay":         "٢٦ رجب ١٤٤٧",
// "hijriCheckOutDisplay":        null,
// "updateAttendanceRequestCount": 0
// }
  /// from Json

    factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
      return AttendanceRecordModel(
        id: json['id'].toString(),
        employeeId: json['employeeId'].toString(),
        employeeName: json['employeeName'] ?? S.current.notAvailable,
        gregorianDate: json['checkDate'] ?? S.current.notAvailable,
        hijriDate: json['hijriCheckInDisplay'] ?? S.current.notAvailable,
        checkInTime: json['checkIn'] != null
            ? DateTime.parse(json['checkIn']).toLocal().toString().substring(11, 16) + ' ص'
            : null,
        isCheckedIn: json['checkIn'] != null,
        checkOutTime: json['checkOut'] != null
            ? DateTime.parse(json['checkOut']).toLocal().toString().substring(11, 16) + ' م'
            : null,
        isCheckedOut: json['checkOut'] != null,
        outMode: json['outMode'],
      );
    }
/// toJson

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeName': employeeName,
      'checkDate': gregorianDate,
      'hijriCheckInDisplay': hijriDate,
      'checkIn': checkInTime != null ? DateTime.parse(checkInTime!).toUtc().toIso8601String() : null,
      'checkOut': checkOutTime != null ? DateTime.parse(checkOutTime!).toUtc().toIso8601String() : null,
      'outMode': outMode,
    };
  }
}
