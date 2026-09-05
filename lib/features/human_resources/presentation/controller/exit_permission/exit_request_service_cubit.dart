import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/exit_permisstion.dart';
import '../../../../../generated/l10n.dart';
import '../../../../services/domain/entity/request_services_entity.dart';
import '../../../domain/entity/permission_time.dart';
import '../../../domain/entity/permission_type.dart';
import '../../../domain/use_cases/exit/create_exit_permission_use_case.dart';
import '../../../domain/use_cases/exit/get_permission_time_use_case.dart';
import '../../../domain/use_cases/exit/get_permission_types_use_case.dart';
import '../../../domain/use_cases/exit/update_exit_permission_use_case.dart';

part 'exit_request_service_state.dart';

class ExitRequestServiceCubit extends Cubit<ExitRequestServiceState> {
  final GetPermissionTimeUseCase _getPermissionTimeUseCase;
  final GetPermissionTypesUseCase _getPermissionTypeUseCase;
  final CreateExitPermissionUseCase _createExitPermissionUseCase;
  final UpdateExitPermissionUseCase _updateExitPermissionUseCase;
  final SessionStorage _sessionStorage;
  final todayDateController = TextEditingController();
  final permissionDateController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();
  final locationController = TextEditingController();
  final hijriDateController = TextEditingController();
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();
  final permissionTypeController = TextEditingController();
  final officeIDController = TextEditingController();
  final durationController = TextEditingController();
  final permissionTimeTypeController = TextEditingController();
  final notesController = TextEditingController();

  List<DropdownMenuItem<String>> permissionTypeItems = [];
  List<DropdownMenuItem<String>> durationItems = [];
  final GlobalKey<FormState> requestFormKey = GlobalKey<FormState>();

  ExitRequestServiceCubit(
    this._createExitPermissionUseCase,
    this._getPermissionTimeUseCase,
    this._getPermissionTypeUseCase,
    this._updateExitPermissionUseCase,
    this._sessionStorage,
  ) : super(const ExitRequestServiceState()) {
    getPermissionTypes();
    getPermissionTimes();
  }

  /// get permission times
  Future getPermissionTimes() async {
    emit(state.copyWith(status: RequestStatus.permissionTimeLoading));
    final result = await _getPermissionTimeUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: RequestStatus.permissionTimeError)),
      (permission) {
        final isAr = S.current.localeee == 'ar';
        durationItems = permission
            .map(
              (time) => DropdownMenuItem(
                // Value sent to the API as `type` (first / med / last).
                value: time.value ?? '',
                child: Text(
                  (isAr ? time.nameAr : time.nameEn) ?? (time.value ?? ''),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
            .toList();
        emit(
          state.copyWith(
            status: RequestStatus.permissionTimeSuccess,
            permissionTimes: permission,
          ),
        );
      },
    );
  }

  /// get permission types
  Future getPermissionTypes() async {
    emit(state.copyWith(status: RequestStatus.permissionTypesLoading));
    final result = await _getPermissionTypeUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: RequestStatus.permissionTypesError)),
      (permission) {
        final isAr = S.current.localeee == 'ar';
        permissionTypeItems = permission
            .map(
              (item) => DropdownMenuItem(
                // Value is the type id, sent to the API as `permission_type`.
                value: item.id.toString(),
                child: Text(
                  (isAr ? item.nameAr : item.nameEn) ?? item.name ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
            .toList();
        emit(
          state.copyWith(
            status: RequestStatus.permissionTypesSuccess,
            permissionTypes: permission,
          ),
        );
      },
    );
  }

  /// create exit permission request
  Future createExitPermissionRequest() async {
    emit(state.copyWith(status: RequestStatus.createExitPermissionLoading));

    final result = await _createExitPermissionUseCase.call(
      params: CreateExitPermissionParams(
          employeeId: int.parse(_sessionStorage.employeeId ?? "1"),
          officeID: officeIDController.text.isEmpty
              ? 0
              : int.parse(officeIDController.text),
          permissionType: int.tryParse(permissionTypeController.text) ?? 0,
          type: permissionTimeTypeController.text,
          exitDate: permissionDateController.text,
          numberOfHours: int.parse(durationController.text),
          stageId: 0,
          leavesAttachment: attachmentFileController.text,
          leavesAttachmentName: attachmentFileNameController.text,
          notes: notesController.text),
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(state.copyWith(
          status: RequestStatus.createExitPermissionError,
          errorMessage: failure.message,
        ));
      },
      (permission) {
        emit(state.copyWith(
            status: RequestStatus.createExitPermissionSuccess,
            successPermission: permission));
      },
    );
  }

  /// update exit permission request
  Future updateExitPermissionRequest({required int requestId}) async {
    emit(state.copyWith(status: RequestStatus.updateExitPermissionLoading));

    final result = await _updateExitPermissionUseCase.call(
      params: UpdateExitPermissionParams(
        requestId: requestId,
        employeeId: int.parse(_sessionStorage.employeeId ?? "1"),
        officeId: officeIDController.text.isEmpty
            ? 0
            : int.parse(officeIDController.text),
        permissionType: int.tryParse(permissionTypeController.text) ?? 0,
        type: permissionTimeTypeController.text,
        exitDate: permissionDateController.text,
        numberOfHours: int.parse(durationController.text),
        stageId: 0,
        leavesAttachment: attachmentFileController.text,
        leavesAttachmentName: attachmentFileNameController.text,
        notes: notesController.text,
      ),
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(state.copyWith(
          status: RequestStatus.updateExitPermissionError,
          errorMessage: failure.message,
        ));
      },
      (permission) {
        emit(state.copyWith(
          status: RequestStatus.updateExitPermissionSuccess,
        ));
      },
    );
  }

  //
  /// open specific question
  void setExpandedIndex(int? index) {
    if (index == null) {
      emit(state.copyWith(clearExpandedIndex: true));
    } else {
      emit(state.copyWith(expandedIndex: index));
    }
  }

  /// delete request
  void deleteExitPermissionRequest() {
    todayDateController.clear();
    permissionDateController.clear();
    applicantNameController.clear();
    organizationalUnitController.clear();
    locationController.clear();
    permissionTypeController.clear();
    hijriDateController.clear();
    durationController.clear();
    permissionTimeTypeController.clear();
    attachmentFileController.clear();
    attachmentFileNameController.clear();
    notesController.clear();
  }

  @override
  Future<void> close() {
    todayDateController.dispose();
    permissionDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    locationController.dispose();
    permissionTypeController.dispose();
    hijriDateController.dispose();
    durationController.dispose();
    permissionTimeTypeController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    notesController.dispose();
    officeIDController.dispose();
    return super.close();
  }
}
