import 'package:equatable/equatable.dart';
import 'attendance_record.dart';

class AllAttendanceRecord extends Equatable {
  final List<AttendanceRecord> attendanceRecords;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;

  const AllAttendanceRecord({
    required this.attendanceRecords,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  @override
  List<Object?> get props =>
      [attendanceRecords, pageNumber, pageSize, totalCount, totalPages];
}
