import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/approve_request_use_case.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/get_all_manager_requests_use_case.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/get_all_user_requests_use_case.dart';
import '../../domain/entities/all_requests_with_stages.dart';
import '../../domain/entities/request_with_stage.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  GetAllUserRequestsUseCase _getAllUserRequestsUseCase;
  GetAllManagerRequestsUseCase _getAllManagerRequestsUseCase;
  ApproveRequestUseCase _approveRequestUseCase;
  final ScrollController userScrollController = ScrollController();
  final ScrollController managerScrollController = ScrollController();
  int userPage = 1;
  int managerPage = 1;
  final TextEditingController commentController = TextEditingController();
  
  // Debounce
  Timer? _userDebounceTimer;
  Timer? _managerDebounceTimer;
  bool _isUserDebouncing = false;
  bool _isManagerDebouncing = false;

  MyRequestsCubit(this._getAllUserRequestsUseCase,
      this._getAllManagerRequestsUseCase, this._approveRequestUseCase)
      : super(const MyRequestsState()) {}

  /// getAllUserRequests with debounce
  Future getAllUserRequests({required int employeeId, bool isFirestTime = true}) async {
    print("========================= User Request  =========================");
    print("========================= User Request  =========================");
    print("========================= User Request  =========================");
    print("========================= User Request  =========================");
    print("========================= User Request  =========================");
    print("========================= User Request  =========================");
    print("========================= User Request  =========================");
    print("========================= User Request  =========================");
    if (_isUserDebouncing) return; // Block if debouncing

    _isUserDebouncing = true;
    
    isFirestTime 
        ? emit(state.copyWith(status: MyRequestsStatus.loading))
        : emit(state.copyWith(status: MyRequestsStatus.pageLoading));
    
    final result = await _getAllUserRequestsUseCase.call(
      params: GetAllUserRequestsParams(
          userId: employeeId,
          requestIds: [0],
          pageNumber: userPage,
          pageSize: 8),
    );
    
    result.fold(
      (failure) => emit(state.copyWith(status: MyRequestsStatus.error)),
      (requests) {
        final List<RequestWithStage> updatedItems = [
          ...(state.itemsUser ?? []),
          ...requests.items
        ];

        emit(state.copyWith(
          status: MyRequestsStatus.success,
          itemsUser: updatedItems,
        ));
      },
    );
    
    userPage = userPage + 1;
    
    // Reset debounce after 500ms
    _userDebounceTimer?.cancel();
    _userDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      _isUserDebouncing = false;
    });
  }

  /// get all manager requests with debounce
  Future getAllManagerRequests({required int managerID, bool isFirestTime = true}) async {
    print("========================= Manager Request  =========================");
    print("========================= Manager Request  =========================");
    print("========================= Manager Request  =========================");
    print("========================= Manager Request  =========================");
    print("========================= Manager Request  =========================");
    print("========================= Manager Request  =========================");
    print("========================= Manager Request  =========================");
    print("========================= Manager Request  =========================");
    if (_isManagerDebouncing) return; // Block if debouncing

    _isManagerDebouncing = true;
    
    isFirestTime 
        ? emit(state.copyWith(status: MyRequestsStatus.loading))
        : emit(state.copyWith(status: MyRequestsStatus.pageLoading));
    
    final result = await _getAllManagerRequestsUseCase.call(
      params: GetAllManagerRequestsParams(
          userId: managerID,
          requestIds: [0],
          pageNumber: managerPage,
          pageSize: 30),
    );
    
    result.fold(
      (failure) => emit(state.copyWith(status: MyRequestsStatus.error)),
      (requests) {
        final List<RequestWithStage> updatedItems = [
          ...(state.itemsManager ?? []),
          ...requests.items
        ];
        
        emit(state.copyWith(
          status: MyRequestsStatus.success,
          itemsManager: updatedItems,
        ));
      },
    );
    
    managerPage = managerPage + 1;
    
    // Reset debounce after 500ms
    _managerDebounceTimer?.cancel();
    _managerDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      _isManagerDebouncing = false;
    });
  }

  /// accept request by manager
  Future acceptRequest({required AcceptRequestParams params}) async {
    emit(state.copyWith(status: MyRequestsStatus.loading));
    final result = await _approveRequestUseCase.call(
      params: params,
    );
    result.fold(
      (failure) => emit(state.copyWith(status: MyRequestsStatus.error)),
      (response) {
        emit(state.copyWith(status: MyRequestsStatus.success));
      },
    );
  }

  @override
  Future<void> close() {
    _userDebounceTimer?.cancel();
    _managerDebounceTimer?.cancel();
    userScrollController.dispose();
    managerScrollController.dispose();
    commentController.dispose();
    return super.close();
  }
}
