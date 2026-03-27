import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/my-services/domain/use_cases/get_permission_time_use_case.dart';

import '../../../domain/entity/request_services_Entity.dart';
import '../../../domain/use_cases/create_exit_permission_use_case.dart';
import '../../../domain/use_cases/get_all_permission_services_use_case.dart';

part 'request_service_state.dart';

class RequestServiceCubit extends Cubit<RequestServiceState> {
  final GetPermissionTimeUseCase _getPermissionTimeUseCase;
  final GetPermissionTimeUseCase _getPermissionTypeUseCase;
  final CreateExitPermissionUseCase _createExitPermissionUseCase;

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
      (failure) => emit(state.copyWith()),
      (permission) => emit(state.copyWith()),
    );
  }

  /// get permission types
  Future getPermissionTypes() async {
    final result = await _getPermissionTypeUseCase.call(params: NoParams());
    result.fold(
          (failure) => emit(state.copyWith()),
          (permission) => emit(state.copyWith()),
    );
  }
  /// create exit permission request
  Future createExitPermissionRequest({
    required String permissionType,
    required String permissionTime,
    required String reason,
  }) async {
    final result = await _createExitPermissionUseCase.call(
      params: CreateExitPermissionParams(employeeId: 8, permissionType: 1, type: "med", exitDate: "mrs", numberOfHours: 7, stageId: 1)
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
