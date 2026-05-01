import 'package:equatable/equatable.dart';

import '../../data/model/attendance_record_model.dart';

class AllAttendanceRecordModel extends Equatable {
  final List<AttendanceRecordModel> attendanceRecords;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;

  const AllAttendanceRecordModel({
    required this.attendanceRecords,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });
  factory AllAttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AllAttendanceRecordModel(
      attendanceRecords: (json['items'] as List)
          .map((e) => AttendanceRecordModel.fromJson(e))
          .toList(),
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
    );
  }
  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'items': attendanceRecords.map((e) => e.toJson()).toList(),
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'totalPages': totalPages,
    };
  }

  @override
  List<Object?> get props => [ attendanceRecords, pageNumber, pageSize, totalCount, totalPages];
}
