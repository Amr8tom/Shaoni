import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/attendance/create_attendance_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/attendance/get_all_missing_attendance_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/attendance/get_attendance_lookup_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/attendance/get_forget_reason_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/attendance/update_attendance_use_case.dart';
import '../../../../../core/local_storage/session_storage/session_storage.dart';
import '../../../../../core/utils/usecases/base_usecase.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/attendance_record.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final GetAllMissingAttendanceUseCase _getAllMissingAttendanceUseCase;
  final CreateAttendanceUseCase _createAttendanceUseCase;
  final GetAttendanceLookupUseCase _getAttendanceLookupUseCase;
  final GetForgetReasonUseCase _getForgetReasonUseCase;
  final UpdateAttendanceUseCase _updateAttendanceUseCase;
  final SessionStorage _sessionStorage;
  final requestFormKey = GlobalKey<FormState>();
  final todayDateController = TextEditingController();

  /// Gregorian date the user picks via the date picker (`yyyy-MM-dd`).
  final attendanceDateController = TextEditingController();

  /// Time-of-day the user picks via the time picker (`HH:mm`).
  final attendanceTimeController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();
  final officeIDController = TextEditingController();
  final durationController = TextEditingController();
  final attendanceTypeController = TextEditingController();
  final forgetReasonController = TextEditingController();
  final orderReasonController = TextEditingController();

  List<DropdownMenuItem<String>> attendanceTypeItems = [];
  List<DropdownMenuItem<String>> forgetReasonItems = [];

  AttendanceCubit(
      this._getAllMissingAttendanceUseCase,
      this._createAttendanceUseCase,
      this._getAttendanceLookupUseCase,
      this._getForgetReasonUseCase,
      this._updateAttendanceUseCase,
      this._sessionStorage)
      : super(const AttendanceState()) {
    getAttendanceRecords();
    _loadLookups();
  }

  Future<void> _loadLookups() async {
    await Future.wait([
      getAttendanceLookup(),
      getForgetReason(),
    ]);
  }

  /// Loads the attendance records and emits success / error / empty states.
  Future<void> getAttendanceRecords() async {
    emit(state.copyWith(status: AttendanceStatus.loading));
    final result = await _getAllMissingAttendanceUseCase.call(
        params: AllMissingAttendanceParams(
            userId: int.parse(_sessionStorage.employeeId ?? "1"),
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
    emit(state.copyWith(status: AttendanceStatus.lookupsLoading));
    final result = await _getAttendanceLookupUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: AttendanceStatus.lookupsError)),
      (permission) {
        attendanceTypeItems = permission
            .map(
              (attendanceType) => DropdownMenuItem(
                value: S.current.localeee == "ar"
                    ? attendanceType.nameAr
                    : attendanceType.nameEn,
                child: Text(
                  S.current.localeee == "ar"
                      ? attendanceType.nameAr
                      : attendanceType.nameEn,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
            .toList();
        emit(
          state.copyWith(
            status: AttendanceStatus.lookupsLoaded,
          ),
        );
      },
    );
  }

  Future<void> getForgetReason() async {
    emit(state.copyWith(status: AttendanceStatus.forgetLoading));
    final result = await _getForgetReasonUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: AttendanceStatus.forgetError)),
      (permission) {
        forgetReasonItems = permission
            .map(
              (reasons) => DropdownMenuItem(
                value: (S.current.localeee == "ar"
                        ? reasons.name
                        : reasons.nameEn) ??
                    '3',
                child: Text(
                  (S.current.localeee == "ar"
                          ? reasons.name
                          : reasons.nameEn) ??
                      '3',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
            .toList();
        emit(
          state.copyWith(
            status: AttendanceStatus.forgetLoaded,
          ),
        );
      },
    );
  }

  /// delete attendance request
  Future<void> deleteAttendanceRequest() async {
    attendanceDateController.clear();
    attendanceTimeController.clear();
    attendanceTypeController.clear();
    orderReasonController.clear();
    forgetReasonController.clear();
    durationController.clear();
  }

  /// create attendance request
  Future<void> createAttendanceRequest() async {
    emit(state.copyWith(
        status: AttendanceStatus.createAttendanceRequestLoading));
    final result = await _createAttendanceUseCase.call(
        params: CreateAttendanceParams(
            employee: int.parse(_sessionStorage.employeeId ?? "1"),
            attendanceType: attendanceTypeController.text == S.current.checkedIn
                ? "check_in"
                : "check_out",
            updateDate:
                '${attendanceDateController.text} ${attendanceTimeController.text}',
            attendanceId: int.parse(state.records.first.odooId),
            officeId: officeIDController.text.isEmpty
                ? 0
                : int.parse(officeIDController.text),
            orderReason: orderReasonController.text,
            forgetReasonsIds: forgetReasonItems.indexWhere(
                    (item) => item.value == forgetReasonController.text) +
                1,
            date: ''));
    result.fold(
      (failure) => emit(state.copyWith(
          status: AttendanceStatus.error, errorMessage: failure.message)),
      (success) => emit(state.copyWith(
          status: AttendanceStatus.createAttendanceRequestLoaded,
          successMessage: success.message,
          requestNumber: success.requestNumber)),
    );
  }

  /// update attendance request
  Future<void> updateAttendanceRequest({required int requestId}) async {
    emit(state.copyWith(
        status: AttendanceStatus.updateAttendanceRequestLoading));
    final result = await _updateAttendanceUseCase.call(
      params: UpdateAttendanceParams(
        requestId: requestId,
        employee: int.parse(_sessionStorage.employeeId ?? "1"),
        officeId: officeIDController.text.isEmpty
            ? 0
            : int.parse(officeIDController.text),
        attendanceType: attendanceTypeController.text == S.current.checkedIn
            ? "check_in"
            : "check_out",
        updateDate:
            '${attendanceDateController.text} ${attendanceTimeController.text}',
        date: attendanceDateController.text,
        attendanceId: state.records.isNotEmpty
            ? (int.tryParse(state.records.first.odooId) ?? 0)
            : 0,
        orderReason: orderReasonController.text,
        forgetReasonsIds: forgetReasonItems.indexWhere(
                (item) => item.value == forgetReasonController.text) +
            1,
        attachmentName: attachmentFileNameController.text,
        attachment: attachmentFileController.text,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
          status: AttendanceStatus.updateAttendanceRequestError,
          errorMessage: failure.message)),
      (success) => emit(state.copyWith(
          status: AttendanceStatus.updateAttendanceRequestLoaded)),
    );
  }

  /// Pull-to-refresh entry point — same flow as initial load.
  Future<void> refresh() => getAttendanceRecords();
}
