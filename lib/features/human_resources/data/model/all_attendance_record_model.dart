import 'package:shaoni/features/human_resources/domain/entity/all_attendance_record.dart';
import 'attendance_record_model.dart';

class AllAttendanceRecordModel extends AllAttendanceRecord {
  const AllAttendanceRecordModel({
    required super.attendanceRecords,
    required super.pageNumber,
    required super.pageSize,
    required super.totalCount,
    required super.totalPages,
  });

  factory AllAttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AllAttendanceRecordModel(
      attendanceRecords: (json['items'] as List)
          .map((e) => AttendanceRecordModel.fromJson(e))
          .toList(),
      pageNumber: json['pageNumber'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      totalCount: json['totalCount'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': attendanceRecords
          .map(AttendanceRecordModel.toJsonFromEntity)
          .toList(),
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'totalPages': totalPages,
    };
  }
}
