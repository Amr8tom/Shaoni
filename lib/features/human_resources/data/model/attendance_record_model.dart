import 'package:shaoni/features/human_resources/domain/entity/attendance_record.dart';

import '../../../../generated/l10n.dart';



//

class AttendanceRecordModel extends AttendanceRecord {
  const AttendanceRecordModel({
    required super.id,
    required super.odooId,
    required super.employeeId,
    required super.employeeName,
    required super.gregorianDate,
    required super.hijriDate,
    required super.checkInTime,
    required super.isCheckedIn,
    required super.checkOutTime,
    required super.isCheckedOut,
    required super.outMode,
    super.displayName,
    super.hijriCheckOutDisplay,
    super.inMode,
  });

  /// from Json

    factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
      return AttendanceRecordModel(
        id: json['id'].toString(),
        odooId: json['odooId'].toString(),
        employeeId: json['employeeId'].toString(),
        employeeName: json['employeeName'] ?? S.current.notAvailable,
        displayName: json['displayName'],
        gregorianDate: json['checkDate'] ?? S.current.notAvailable,
        hijriDate: json['hijriCheckInDisplay'] ?? S.current.notAvailable,
        hijriCheckOutDisplay: json['hijriCheckOutDisplay'],
        inMode: json['inMode'],
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
      'odooId': odooId,
      'employeeName': employeeName,
      'checkDate': gregorianDate,
      'hijriCheckInDisplay': hijriDate,
      'checkIn': checkInTime != null ? DateTime.parse(checkInTime!).toUtc().toIso8601String() : null,
      'checkOut': checkOutTime != null ? DateTime.parse(checkOutTime!).toUtc().toIso8601String() : null,
      'outMode': outMode,
    };
  }
}
