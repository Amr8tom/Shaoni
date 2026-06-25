import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/approve_request_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_all_kafeel_requests_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_all_manager_requests_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_all_user_requests_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_request_details_use_case.dart';
import '../../domain/entities/all_requests_with_stages.dart';
import '../../domain/entities/request_with_stage.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  final GetAllUserRequestsUseCase _getAllUserRequestsUseCase;
  final GetRequestDetailsUseCase _getRequestDetailsUseCase;
  final GetAllManagerRequestsUseCase _getAllManagerRequestsUseCase;
  final GetAllKafeelRequestsUseCase _getAllKafeelRequestsUseCase;
  final ApproveRequestUseCase _approveRequestUseCase;
  final ScrollController userScrollController = ScrollController();
  final ScrollController managerScrollController = ScrollController();
  final ScrollController kafeelScrollController = ScrollController();
  int userPage = 1;
  int managerPage = 1;
  int kafeelPage = 1;
  final TextEditingController commentController = TextEditingController();

  // Debounce
  Timer? _userDebounceTimer;
  Timer? _managerDebounceTimer;
  Timer? _kafeelDebounceTimer;
  bool _isUserDebouncing = false;
  bool _isManagerDebouncing = false;
  bool _isKafeelDebouncing = false;

  MyRequestsCubit(
      this._getAllUserRequestsUseCase,
      this._getAllManagerRequestsUseCase,
      this._getAllKafeelRequestsUseCase,
      this._approveRequestUseCase,
      this._getRequestDetailsUseCase)
      : super(const MyRequestsState());

  /// getAllUserRequests with debounce
  Future getAllUserRequests(
      {required int employeeId, bool isFirestTime = true}) async {
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
          pageSize: 12),
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(status: MyRequestsStatus.error)),
      (requests) {
        final List<RequestWithStage> updatedItems = [
          ...state.itemsUser,
          ...requests.items
        ];
        emit(state.copyWith(
          status: MyRequestsStatus.success,
          userRequests: requests,
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
  Future getAllManagerRequests(
      {required int managerID, bool isFirestTime = true}) async {
    if (_isManagerDebouncing) return;

    _isManagerDebouncing = true;

    isFirestTime
        ? emit(state.copyWith(status: MyRequestsStatus.loading))
        : emit(state.copyWith(status: MyRequestsStatus.pageLoading));

    final result = await _getAllManagerRequestsUseCase.call(
      params: GetAllManagerRequestsParams(
          userId: managerID,
          requestIds: [0],
          pageNumber: managerPage,
          pageSize: 12),
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(status: MyRequestsStatus.error)),
      (requests) {
        final List<RequestWithStage> updatedItems = [
          ...state.itemsManager,
          ...requests.items
        ];

        emit(state.copyWith(
          status: MyRequestsStatus.success,
          managerRequests: requests,
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

  /// get all kafeel requests with debounce
  Future getAllKafeelRequests(
      {required int userId, bool isFirestTime = true}) async {
    if (_isKafeelDebouncing) return;

    _isKafeelDebouncing = true;

    isFirestTime
        ? emit(state.copyWith(status: MyRequestsStatus.loading))
        : emit(state.copyWith(status: MyRequestsStatus.pageLoading));

    final result = await _getAllKafeelRequestsUseCase.call(
      params: GetAllKafeelRequestsParams(
          userId: userId, pageNumber: kafeelPage, pageSize: 12),
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(status: MyRequestsStatus.error)),
      (requests) {
        final List<RequestWithStage> updatedItems = [
          ...state.itemsKafeel,
          ...requests.items
        ];

        emit(state.copyWith(
          status: MyRequestsStatus.success,
          kafeelRequests: requests,
          itemsKafeel: updatedItems,
        ));
      },
    );

    kafeelPage = kafeelPage + 1;

    // Reset debounce after 500ms
    _kafeelDebounceTimer?.cancel();
    _kafeelDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      _isKafeelDebouncing = false;
    });
  }

  /// request details
  Future<RequestWithStage?> getRequestDetails({required int? requestId}) async {
    emit(state.copyWith(status: MyRequestsStatus.loading));
    final result = await _getRequestDetailsUseCase.call(
      params: GetRequestDetailsParams(requestId: requestId!),
    );
    if (isClosed) return null;
    result
        .fold((failure) => emit(state.copyWith(status: MyRequestsStatus.error)),
            (response) {
      emit(state.copyWith(
          status: MyRequestsStatus.success, requestDetails: response));
    });
    return null;
  }

  /// accept request by manager
  Future acceptRequest({required AcceptRequestParams params}) async {
    emit(state.copyWith(status: MyRequestsStatus.sendRequestLoading));
    final result = await _approveRequestUseCase.call(
      params: params,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(status: MyRequestsStatus.error)),
      (response) {
        emit(state.copyWith(status: MyRequestsStatus.sendRequestSuccess));
      },
    );
  }

  @override
  Future<void> close() {
    _userDebounceTimer?.cancel();
    _managerDebounceTimer?.cancel();
    _kafeelDebounceTimer?.cancel();
    userScrollController.dispose();
    managerScrollController.dispose();
    kafeelScrollController.dispose();
    commentController.dispose();
    return super.close();
  }
}
