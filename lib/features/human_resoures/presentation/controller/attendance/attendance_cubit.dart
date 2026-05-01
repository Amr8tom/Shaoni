import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/get_all_missing_attendance_use_case.dart';

import '../../../domain/entity/attendance_record.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final GetAllMissingAttendanceUseCase _getAllMissingAttendanceUseCase;

  AttendanceCubit(this._getAllMissingAttendanceUseCase)
      : super(const AttendanceState()) {
    getAttendanceRecords();
  }

  /// Loads the attendance records and emits success / error / empty states.
  Future<void> getAttendanceRecords() async {
    emit(state.copyWith(status: AttendanceStatus.loading));
    final result = await _getAllMissingAttendanceUseCase.call(
        params:
            AllMissingAttendanceParams(userId: 1, pageNumber: 1, pageSize: 10));
    result.fold(
      (failure) => emit(state.copyWith(
          status: AttendanceStatus.error, errorMessage: failure.message)),
      (records) {
        if (records.attendanceRecords.isEmpty) {
          emit(state.copyWith(status: AttendanceStatus.empty));
        } else {
          emit(state.copyWith(status: AttendanceStatus.loaded, records: records.attendanceRecords));
        }
      },
    );
  }

  /// Pull-to-refresh entry point — same flow as initial load.
  Future<void> refresh() => getAttendanceRecords();

  // ---------------------------------------------------------------------
  // Future<List<AttendanceRecord>> _fetchRecords() async {
  //   /// Simulate network latency so the UI loading state is visible
  //   /// during development.
  //   await Future.delayed(const Duration(milliseconds: 600));
  //
  //   return const [
  //     AttendanceRecord(
  //       id: '1',
  //       employeeName: 'محمد علي',
  //       gregorianDate: '2026-01-26',
  //       hijriDate: '١ رجب ١٤٤٧',
  //       checkInTime: '07:30 ص',
  //       isCheckedIn: true,
  //       checkOutTime: null,
  //       isCheckedOut: false,
  //       outMode: null,
  //       employeeId: '3',
  //     ),
  //     AttendanceRecord(
  //       id: '2',
  //       employeeName: 'محمد علي',
  //       gregorianDate: '2026-01-25',
  //       hijriDate: '٣٠ جمادى الآخرة ١٤٤٧',
  //       checkInTime: '07:45 ص',
  //       isCheckedIn: true,
  //       checkOutTime: '04:10 م',
  //       isCheckedOut: true,
  //       outMode: 'نهاية الدوام',
  //       employeeId: '2',
  //     ),
  //     AttendanceRecord(
  //       id: '3',
  //       employeeName: 'محمد علي',
  //       gregorianDate: '2026-01-24',
  //       hijriDate: '٢٩ جمادى الآخرة ١٤٤٧',
  //       checkInTime: '08:05 ص',
  //       isCheckedIn: true,
  //       checkOutTime: '04:00 م',
  //       isCheckedOut: true,
  //       outMode: 'إذن خروج',
  //       employeeId: '1',
  //     ),
  //   ];
  // }
}
