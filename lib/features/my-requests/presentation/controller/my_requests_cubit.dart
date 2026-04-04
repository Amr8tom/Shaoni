import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/approve_request_use_case.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/get_all_manager_requests_use_case.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/get_all_user_requests_use_case.dart';
import '../../domain/entities/all_requests_with_stages.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  GetAllUserRequestsUseCase _getAllUserRequestsUseCase;
  GetAllManagerRequestsUseCase _getAllManagerRequestsUseCase;
  ApproveRequestUseCase _approveRequestUseCase;
  final TextEditingController commentController = TextEditingController();


  MyRequestsCubit(this._getAllUserRequestsUseCase,
      this._getAllManagerRequestsUseCase, this._approveRequestUseCase)
      : super(const MyRequestsState()) {}

  /// getAllUserRequests
  Future getAllUserRequests({required int employeeId}) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _getAllUserRequestsUseCase.call(
      params: GetAllUserRequestsParams(
          userId: employeeId,
          requestIds: [0],
          pageNumber: 1,
          pageSize: 15),
    );
    result.fold(
          (failure) => emit(state.copyWith(status: GeneralStatus.error)),
          (requests) =>
          emit(
            state.copyWith(
              status: GeneralStatus.success,
              requests: requests,
            ),
          ),
    );
  }

  /// get all manager requests
  Future getAllManagerRequests({required int managerID}) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _getAllManagerRequestsUseCase.call(
      params: GetAllManagerRequestsParams(
        // userId: int.parse(CacheHelper.getString(key: CacheKeys.employeeId)??''),
          userId: managerID,
          requestIds: [0],
          pageNumber: 1,
          pageSize: 15),
    );
    result.fold(
          (failure) => emit(state.copyWith(status: GeneralStatus.error)),
          (requests) =>
          emit(
            state.copyWith(
              status: GeneralStatus.success,
              requests: requests,
            ),
          ),
    );
  }

  /// accept request by manager
  Future acceptRequest({required AcceptRequestParams params}) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _approveRequestUseCase.call(
      params: params,
    );
    result.fold(
          (failure) => emit(state.copyWith(status: GeneralStatus.error)),
          (response) => emit(state.copyWith(status: GeneralStatus.success)),
    );
  }

  }
