import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/exit_permisstion.dart';
import '../../../domain/entity/permission_time.dart';
import '../../../domain/entity/permission_type.dart';
import '../../../domain/entity/request_services_Entity.dart';
import '../../../domain/use_cases/exit/create_exit_permission_use_case.dart';
import '../../../domain/use_cases/exit/get_permission_time_use_case.dart';
import '../../../domain/use_cases/exit/get_permission_types_use_case.dart';

part 'exit_request_service_state.dart';

class ExitRequestServiceCubit extends Cubit<ExitRequestServiceState> {
  final GetPermissionTimeUseCase _getPermissionTimeUseCase;
  final GetPermissionTypesUseCase _getPermissionTypeUseCase;
  final CreateExitPermissionUseCase _createExitPermissionUseCase;
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
  ) : super(const ExitRequestServiceState()) {
    getPermissionTypes();
    getPermissionTimes();
  }

  /// get permission times
  Future getPermissionTimes() async {
    emit(state.copyWith(status: RequestStatus.permissionTimeLoading));
    final result = await _getPermissionTimeUseCase.call(params: NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: RequestStatus.permissionTimeError)),
      (permission) {
        durationItems = permission
            .map(
              (time) => DropdownMenuItem(
                value: time.name ?? '3',
                child: Text(
                  time.name ?? '3',
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
    result.fold(
      (failure) =>
          emit(state.copyWith(status: RequestStatus.permissionTypesError)),
      (permission) {
        permissionTypeItems = permission
            .map(
              (item) => DropdownMenuItem(
                value: item.name ?? '3',
                child: Text(item.name ?? '3'),
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

  // هو الفايل ملهوش دعوه
  // {
  // "employee_id": 2,
  // "permission_type": 1,
  // "type": "first",
  // "exit_date": "2026-3-29",
  // "number_of_hours": 1,
  // "notes": "test",
  // "stage_id": 1,
  // "leaves_attachment": "test by amr",
  // "leaves_attachment_name": "test"
  // }

  /// create exit permission request
  Future createExitPermissionRequest() async {
    emit(state.copyWith(status: RequestStatus.createExitPermissionLoading));

    final result = await _createExitPermissionUseCase.call(
      params: CreateExitPermissionParams(
          employeeId: int.parse(
              CacheHelper.getString(key: CacheKeys.employeeId) ?? "1"),
          officeID: officeIDController.text.isEmpty
              ? 0
              : int.parse(officeIDController.text),
          permissionType: permissionTypeItems.indexWhere(
                  (item) => item.value == permissionTypeController.text) +
              1,
          type: permissionTimeTypeController.text,
          exitDate: permissionDateController.text,
          numberOfHours: int.parse(durationController.text),
          stageId: 0,
          leavesAttachment: attachmentFileController.text ?? '',
          leavesAttachmentName: attachmentFileNameController.text ?? '',
          notes: notesController.text ?? 'notes'),
    );

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
    // setExpandedIndex(null);
  }

  void dispose() {
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
  }
}
