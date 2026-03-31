import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/my-services/domain/entity/permission_time.dart';
import 'package:shaoni/features/my-services/domain/entity/permission_type.dart';
import 'package:shaoni/features/my-services/domain/use_cases/get_permission_time_use_case.dart';
import 'package:shaoni/features/my-services/domain/use_cases/get_permission_types_use_case.dart';
import '../../../domain/entity/request_services_Entity.dart';
import '../../../domain/use_cases/create_exit_permission_use_case.dart';
part 'request_service_state.dart';


class RequestServiceCubit extends Cubit<RequestServiceState> {
  final GetPermissionTimeUseCase _getPermissionTimeUseCase;
  final GetPermissionTypesUseCase _getPermissionTypeUseCase;
  final CreateExitPermissionUseCase _createExitPermissionUseCase;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController applicantNameController = TextEditingController();
  final TextEditingController organizationalUnitController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController permissionTypeController =
      TextEditingController();
  final TextEditingController hijriDateController = TextEditingController();
  final TextEditingController durationItemsController = TextEditingController();
  final TextEditingController permissionTimeTypeController =
      TextEditingController();
  List<DropdownMenuItem<String>> permissionTypeItems = [];
  List<DropdownMenuItem<String>> durationItems = [];

  RequestServiceCubit(
    this._createExitPermissionUseCase,
    this._getPermissionTimeUseCase,
    this._getPermissionTypeUseCase,
  ) : super(const RequestServiceState()) {
    getPermissionTypes();
    getPermissionTimes();
  }

  /// get permission times
  Future getPermissionTimes() async {
    final result = await _getPermissionTimeUseCase.call(params: NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: RequestStatus.permissionTimeError)),
      (permission) {
        durationItems =
            permission
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
    final result = await _getPermissionTypeUseCase.call(params: NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: RequestStatus.permissionTypesError)),
      (permission) {
        permissionTypeItems =
            permission
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

  /// create exit permission request
  Future createExitPermissionRequest({
    required String permissionType,
    required String permissionTime,
    required String reason,
  }) async {
    final result = await _createExitPermissionUseCase.call(
      params: CreateExitPermissionParams(
        employeeId: int.parse(CacheHelper.getString(key: CacheKeys.employeeId) ?? "1" ),
        permissionType:int.parse(permissionTimeTypeController.text) ,
        type: permissionTimeTypeController.text ,
        exitDate: dateController.text,
        numberOfHours: int.parse(durationItemsController.text),
        notes: "",
        stageId: 0,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith()),
      (permission) => emit(state.copyWith()),
    );
  }

  /// open specific question
  void setExpandedIndex(int? index) {
    if (index == null) {
      emit(state.copyWith(clearExpandedIndex: true));
    } else {
      emit(state.copyWith(expandedIndex: index));
    }
  }
}
