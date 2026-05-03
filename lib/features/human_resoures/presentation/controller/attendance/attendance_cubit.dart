import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/create_attendance_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/get_all_missing_attendance_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/get_attendance_lookup_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/get_forget_reason_use_case.dart';
import '../../../../../core/local_storage/cache_helper.dart';
import '../../../../../core/local_storage/cache_keys.dart';
import '../../../../../core/utils/usecases/base_usecase.dart';
import '../../../domain/entity/attendance_record.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final GetAllMissingAttendanceUseCase _getAllMissingAttendanceUseCase;
  final CreateAttendanceUseCase _createAttendanceUseCase;
  final GetAttendanceLookupUseCase _getAttendanceLookupUseCase;
  final GetForgetReasonUseCase _getForgetReasonUseCase;
  final requestFormKey = GlobalKey<FormState>();
  final TextEditingController todayDateController = TextEditingController();
  final TextEditingController permissionDateController =
      TextEditingController();
  final TextEditingController applicantNameController = TextEditingController();
  final TextEditingController organizationalUnitController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController hijriDateController = TextEditingController();
  final TextEditingController attachmentFileController =
      TextEditingController();
  final TextEditingController attachmentFileNameController =
      TextEditingController();
  final TextEditingController permissionTypeController =
      TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController permissionTimeTypeController =
      TextEditingController();
  final TextEditingController orderReasonController = TextEditingController();

  // List<DropdownMenuItem<String>> permissionTypeItems = [];
  // List<DropdownMenuItem<String>> durationItems = [];

  AttendanceCubit(
      this._getAllMissingAttendanceUseCase,
      this._createAttendanceUseCase,
      this._getAttendanceLookupUseCase,
      this._getForgetReasonUseCase)
      : super(const AttendanceState()) {
    getAttendanceLookup();
    getForgetReason();
    getAttendanceRecords();
  }

  /// Loads the attendance records and emits success / error / empty states.
  Future<void> getAttendanceRecords() async {
    emit(state.copyWith(status: AttendanceStatus.loading));
    final result = await _getAllMissingAttendanceUseCase.call(
        params: AllMissingAttendanceParams(
            userId: int.parse(
                CacheHelper.getString(key: CacheKeys.employeeId) ?? "1"),
            pageNumber: 1,
            pageSize: 10));
    result.fold(
      (failure) => emit(state.copyWith(
          status: AttendanceStatus.error, errorMessage: failure.message)),
      (records) {
        if (records.attendanceRecords.isEmpty) {
          emit(state.copyWith(status: AttendanceStatus.empty));
        } else {
          emit(state.copyWith(
              status: AttendanceStatus.loaded,
              records: records.attendanceRecords));
        }
      },
    );
  }
  /// get attendance lookup data
  Future<void> getAttendanceLookup() async {
      emit(state.copyWith(status: AttendanceStatus.loading));
      final result = await _getAttendanceLookupUseCase.call(params: NoParams());
    // result.fold(
    //   (failure) => emit(state.copyWith(status: AttendanceStatus.error, errorMessage: failure.message)),
    //   (lookupData) => emit(state.copyWith(status: AttendanceStatus.loaded, lookupData: lookupData)),
    // );
  }

  Future<void> getForgetReason() async {
      emit(state.copyWith(status: AttendanceStatus.loading));
      final result = await _getForgetReasonUseCase.call(params: NoParams());
    // result.fold(
    //   (failure) => emit(state.copyWith(status: AttendanceStatus.error, errorMessage: failure.message)),
    //   (forgetReasons) => emit(state.copyWith(status: AttendanceStatus.loaded, forgetReasons: forgetReasons)),
    // );
  }

  /// delete attendance request
  Future<void> deleteAttendanceRequest() async {}

  /// create attendance request
  Future<void> createAttendanceRequest() async {
    emit(state.copyWith(status: AttendanceStatus.loading));
    final result = await _createAttendanceUseCase.call(
        params: CreateAttendanceParams(
            employee: 6,
            attendanceType: '',
            updateDate: '',
            attendanceId: 2,
            orderReason: orderReasonController.text,
            forgetReasonsIds: 2,
            date: ''));
  }

  /// Pull-to-refresh entry point — same flow as initial load.
  Future<void> refresh() => getAttendanceRecords();
}
