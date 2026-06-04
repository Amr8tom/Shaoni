import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/start_work/employee.dart';
import 'package:shaoni/features/human_resources/domain/entity/start_work/start_work_type.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/create_start_work_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/get_employees_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/get_start_work_types_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/update_start_work_use_case.dart';
import 'package:shaoni/generated/l10n.dart';

part 'start_work_state.dart';

class StartWorkCubit extends Cubit<StartWorkState> {
  final GetStartWorkTypesUseCase _getStartWorkTypesUseCase;
  final GetEmployeesUseCase _getEmployeesUseCase;
  final CreateStartWorkUseCase _createStartWorkUseCase;
  final UpdateStartWorkUseCase _updateStartWorkUseCase;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// ── Applicant controllers ────────────────────────────────────────────────
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();
  final officeIdController = TextEditingController();

  /// ── Request-specific controllers ────────────────────────────────────────
  final startWorkTypeController = TextEditingController();
  final employeeController = TextEditingController();
  final startDateController = TextEditingController();
  final noteController = TextEditingController();

  /// ── Attachment controllers ───────────────────────────────────────────────
  final attachmentFileController = TextEditingController();

  /// Dropdown items for the UI
  List<DropdownMenuItem<String>> startWorkTypeItems = [];
  List<DropdownMenuItem<String>> employeeItems = [];

  /// Raw lists for ID resolution
  List<StartWorkType> _startWorkTypes = [];
  List<Employee> _employees = [];

  StartWorkCubit(
    this._getStartWorkTypesUseCase,
    this._getEmployeesUseCase,
    this._createStartWorkUseCase,
    this._updateStartWorkUseCase,
  ) : super(const StartWorkState()) {
    _loadLookups();
  }

  /// ── Lookups ──────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: StartWorkStatus.lookupsLoading));
    await Future.wait([_fetchStartWorkTypes(), _fetchEmployees()]);
    emit(state.copyWith(status: StartWorkStatus.lookupsLoaded));
  }

  Future<void> _fetchStartWorkTypes() async {
    final result = await _getStartWorkTypesUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: StartWorkStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (types) {
        _startWorkTypes = types;
        startWorkTypeItems = types
            .map((t) => DropdownMenuItem<String>(
                  value: _localizedName(t.nameAr, t.nameEn),
                  child: Text(
                    _localizedName(t.nameAr, t.nameEn),
                    style: const TextStyle(fontSize: 12),
                  ),
                ))
            .toList();
      },
    );
  }

  Future<void> _fetchEmployees() async {
    final result = await _getEmployeesUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: StartWorkStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (employees) {
        _employees = employees;
        employeeItems = employees
            .map((e) => DropdownMenuItem<String>(
                  value: e.displayName,
                  child: Text(
                    e.displayName,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList();
      },
    );
  }

  /// ── Helpers: resolve selected display name → ID ──────────────────────────

  int? get _selectedTypeId {
    if (startWorkTypeController.text.isEmpty) return null;
    final match = _startWorkTypes.where(
      (t) => _localizedName(t.nameAr, t.nameEn) == startWorkTypeController.text,
    );
    return match.isEmpty ? null : match.first.id;
  }

  int? get _selectedEmployeeId {
    if (employeeController.text.isEmpty) return null;
    final match = _employees.where(
      (e) => e.displayName == employeeController.text,
    );
    return match.isEmpty ? null : match.first.id;
  }

  /// ── Create ───────────────────────────────────────────────────────────────

  Future<void> createStartWorkRequest() async {
    emit(state.copyWith(status: StartWorkStatus.createLoading));

    final result = await _createStartWorkUseCase.call(
      params: CreateStartWorkParams(
        date: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
        employee: _selectedEmployeeId ?? 0,
        managerId: int.tryParse(
                CacheHelper.getString(key: CacheKeys.employeeId) ?? '0') ??
            0,
        officeId: int.tryParse(officeIdController.text) ?? 0,
        startDate: startDateController.text.trim(),
        typeId: _selectedTypeId ?? 0,
        note: noteController.text.trim(),
        attachment: attachmentFileController.text.trim(),
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: StartWorkStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: StartWorkStatus.createLoaded,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  /// ── Update ───────────────────────────────────────────────────────────────

  Future<void> updateStartWorkRequest({required int requestId}) async {
    emit(state.copyWith(status: StartWorkStatus.createLoading));

    final result = await _updateStartWorkUseCase.call(
      params: UpdateStartWorkParams(
        requestId: requestId,
        data: CreateStartWorkParams(
          date: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
          employee: _selectedEmployeeId ?? 0,
          managerId: int.tryParse(
                  CacheHelper.getString(key: CacheKeys.employeeId) ?? '0') ??
              0,
          officeId: int.tryParse(officeIdController.text) ?? 0,
          startDate: startDateController.text.trim(),
          typeId: _selectedTypeId ?? 0,
          note: noteController.text.trim(),
          attachment: attachmentFileController.text.trim(),
        ),
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: StartWorkStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: StartWorkStatus.createLoaded,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  /// ── Reset ────────────────────────────────────────────────────────────────

  void deleteStartWorkRequest() {
    applicantNameController.clear();
    organizationalUnitController.clear();
    officeIdController.clear();
    startWorkTypeController.clear();
    employeeController.clear();
    startDateController.clear();
    noteController.clear();
    attachmentFileController.clear();
  }

  /// ── Private helpers ──────────────────────────────────────────────────────

  String _localizedName(String ar, String en) {
    return S.current.localeee == 'en'
        ? (en.isEmpty ? ar : en)
        : (ar.isEmpty ? en : ar);
  }

  @override
  Future<void> close() {
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    officeIdController.dispose();
    startWorkTypeController.dispose();
    employeeController.dispose();
    startDateController.dispose();
    noteController.dispose();
    attachmentFileController.dispose();
    return super.close();
  }
}
