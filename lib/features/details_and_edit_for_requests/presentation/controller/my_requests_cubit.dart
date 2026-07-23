import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/approve_request_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_all_kafeel_requests_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_all_manager_requests_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_all_user_requests_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_request_details_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/outside_working_line_action_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_outside_working_requests_use_case.dart';
import 'package:shaoni/core/constants/service_codes.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import '../../domain/entities/all_requests_with_stages.dart';
import '../../domain/entities/request_with_stage.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  final GetAllUserRequestsUseCase _getAllUserRequestsUseCase;
  final GetRequestDetailsUseCase _getRequestDetailsUseCase;
  final GetAllManagerRequestsUseCase _getAllManagerRequestsUseCase;
  final GetAllKafeelRequestsUseCase _getAllKafeelRequestsUseCase;
  final ApproveRequestUseCase _approveRequestUseCase;
  final OutsideWorkingLineActionUseCase _outsideWorkingLineActionUseCase;
  final GetOutsideWorkingRequestsUseCase _getOutsideWorkingRequestsUseCase;
  final SessionStorage _sessionStorage;

  /// The outside-working grid follows the logged-in role convention already
  /// used by the requests screen (job title == 'manager').
  bool get isManagerUser =>
      _sessionStorage.jobTitle?.toLowerCase() == 'manager';
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
      this._getRequestDetailsUseCase,
      this._outsideWorkingLineActionUseCase,
      this._getOutsideWorkingRequestsUseCase,
      this._sessionStorage)
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
    await result.fold(
      (failure) async => emit(state.copyWith(status: MyRequestsStatus.error)),
      (requests) async {
        // Outside-working requests come from their own endpoint, so drop any
        // that leak through the generic by-user list to avoid duplicates.
        final byUserItems =
            requests.items.where((i) => !_isOutsideWorking(i)).toList();

        // Load the dedicated outside-working list once, on the first page.
        final owItems =
            isFirestTime ? await _fetchOutsideWorkingRequests() : const [];

        final List<RequestWithStage> updatedItems = [
          ...state.itemsUser,
          ...owItems,
          ...byUserItems,
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

  bool _isOutsideWorking(RequestWithStage item) =>
      ServiceCode.fromCode(item.service?.nameEn ?? item.service?.code) ==
      ServiceCode.outsideWorking;

  /// Fetches the dedicated outside-working list for the current user.
  Future<List<RequestWithStage>> _fetchOutsideWorkingRequests() async {
    final userId = int.tryParse(_sessionStorage.userId ?? '0') ?? 0;
    if (userId == 0) return const [];
    final result = await _getOutsideWorkingRequestsUseCase.call(
      params: GetOutsideWorkingRequestsParams(userId: userId),
    );
    return result.fold((_) => const [], (data) => data.items);
  }

  /// Employee / manager accept / refuse on a single outside-working line.
  /// Allowed regardless of the request's current stage.
  ///
  /// Returns true when the action succeeded, so the caller can confirm and
  /// navigate away.
  Future<bool> outsideWorkingLineAction({
    required int lineId,
    required OutsideWorkingLineAction action,
    String cancelReason = '',
  }) async {
    emit(state.copyWith(status: MyRequestsStatus.sendRequestLoading));
    final result = await _outsideWorkingLineActionUseCase.call(
      params: OutsideWorkingLineActionParams(
        lineId: lineId,
        action: action,
        cancelReason: cancelReason,
      ),
    );
    if (isClosed) return false;
    return result.fold(
      (failure) {
        emit(state.copyWith(status: MyRequestsStatus.error));
        return false;
      },
      (response) {
        emit(state.copyWith(status: MyRequestsStatus.sendRequestSuccess));
        return response.isSuccess;
      },
    );
  }

  /// set filter
  void setFilter(String? serviceCode) {
    emit(state.copyWith(selectedServiceCode: serviceCode));
  }

  /// clear filter
  void clearFilter() {
    emit(MyRequestsState(
      status: state.status,
      itemsUser: state.itemsUser,
      itemsManager: state.itemsManager,
      itemsKafeel: state.itemsKafeel,
      userRequests: state.userRequests,
      managerRequests: state.managerRequests,
      kafeelRequests: state.kafeelRequests,
      requestDetails: state.requestDetails,
      selectedServiceCode: null,
    ));
  }

  /// Get unique service types from all loaded items (User, Manager, Kafeel)
  List<Map<String, String>> get availableServiceTypes {
    final allItems = [
      ...state.itemsUser,
      ...state.itemsManager,
      ...state.itemsKafeel,
    ];

    final Map<String, String> uniqueServices = {};
    for (var item in allItems) {
      final nameEn = item.service?.nameEn;
      final nameAr = item.service?.nameAr;
      if (nameEn != null && nameAr != null) {
        uniqueServices[nameEn] = nameAr;
      }
    }

    return uniqueServices.entries
        .map((e) => {'nameEn': e.key, 'nameAr': e.value})
        .toList();
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
