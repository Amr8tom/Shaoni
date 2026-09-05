import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_custody.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_lot.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/stock_request_entity.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_reason_entity.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/get_custodies_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/get_stock_requests_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/get_scrap_reasons_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/get_product_lots_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/create_scrap_request_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/update_scrap_request_use_case.dart';

part 'scrap_request_state.dart';

class ScrapRequestCubit extends Cubit<ScrapRequestState> {
  final GetCustodiesUseCase _getCustodiesUseCase;
  final GetStockRequestsUseCase _getStockRequestsUseCase;
  final GetScrapReasonsUseCase _getScrapReasonsUseCase;
  final GetProductLotsUseCase _getProductLotsUseCase;
  final CreateScrapRequestUseCase _createScrapRequestUseCase;
  final UpdateScrapRequestUseCase _updateScrapRequestUseCase;
  final SessionStorage _sessionStorage;

  final requestFormKey = GlobalKey<FormState>();

  final officeIdController = TextEditingController();
  final todayDateController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();

  final Map<String, TextEditingController> _qtyControllers = {};
  final Map<String, TextEditingController> _reasonControllers = {};

  int _itemCounter = 0;

  ScrapRequestCubit(
    this._getCustodiesUseCase,
    this._getStockRequestsUseCase,
    this._getScrapReasonsUseCase,
    this._getProductLotsUseCase,
    this._createScrapRequestUseCase,
    this._updateScrapRequestUseCase,
    this._sessionStorage,
  ) : super(const ScrapRequestState()) {
    _loadLookups();
    _addLineItem();
  }

  // ── Lookups ──────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: ScrapRequestStatus.lookupsLoading));
    final empId = int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0;

    final results = await Future.wait([
      _getCustodiesUseCase.call(params: GetCustodiesParams(employeeId: empId)),
      _getStockRequestsUseCase.call(params: NoParams()),
      _getScrapReasonsUseCase.call(params: NoParams()),
    ]);

    if (isClosed) return;

    final custodiesResult =
        results[0] as dynamic; // Either<Failure, List<ScrapCustody>>
    final stockResult =
        results[1] as dynamic; // Either<Failure, List<StockRequestEntity>>
    final reasonResult =
        results[2] as dynamic; // Either<Failure, List<ScrapReasonEntity>>

    List<ScrapCustody> custodies = [];
    List<StockRequestEntity> stockRequests = [];
    List<ScrapReasonEntity> scrapReasons = [];
    String? error;

    custodiesResult.fold(
      (f) => error = f.message,
      (data) => custodies = data as List<ScrapCustody>,
    );
    stockResult.fold(
      (f) => error ??= f.message,
      (data) => stockRequests = data as List<StockRequestEntity>,
    );
    reasonResult.fold(
      (f) => error ??= f.message,
      (data) => scrapReasons = data as List<ScrapReasonEntity>,
    );

    if (isClosed) return;
    emit(state.copyWith(
      status: error != null
          ? ScrapRequestStatus.lookupsError
          : ScrapRequestStatus.lookupsLoaded,
      custodies: custodies,
      stockRequests: stockRequests,
      scrapReasons: scrapReasons,
      errorMessage: error,
    ));
  }

  Future<void> loadLotsForProduct(int productId) async {
    if (state.lots.containsKey(productId)) return;
    final result = await _getProductLotsUseCase.call(
      params: GetProductLotsParams(productId: productId),
    );
    if (isClosed) return;
    result.fold(
      (_) {},
      (lots) {
        final updated = Map<int, List<ScrapLot>>.from(state.lots);
        updated[productId] = lots;
        emit(state.copyWith(lots: updated));
      },
    );
  }

  // ── Header field setters ─────────────────────────────────────────────────

  /// Add or remove a custody from the header multi-select.
  void toggleCustody(ScrapCustody custody) {
    final ids = List<int>.from(state.selectedCustodyIds);
    if (ids.contains(custody.id)) {
      ids.remove(custody.id);
    } else {
      ids.add(custody.id);
    }
    emit(state.copyWith(selectedCustodyIds: ids));

    // Preload lots for every product now available.
    for (final p in state.availableProducts) {
      loadLotsForProduct(p.id);
    }

    // Drop any line whose product is no longer offered by the selected
    // custodies (prevents stale product/lot selections and dropdown crashes).
    final availableIds = state.availableProducts.map((p) => p.id).toSet();
    final updated = state.lineItems
        .map((item) =>
            item.productId != null && !availableIds.contains(item.productId)
                ? item.copyWith(clearProduct: true, clearLot: true)
                : item)
        .toList();
    emit(state.copyWith(lineItems: updated));
  }

  /// Pick the product for a single line (from the selected custodies' pool).
  void selectLineProduct(String localId, int productId, String productName) {
    loadLotsForProduct(productId);
    final items = state.lineItems.map((i) {
      if (i.localId != localId) return i;
      return i.copyWith(
        productId: productId,
        productName: productName,
        clearLot: true,
      );
    }).toList();
    emit(state.copyWith(lineItems: items));
  }

  void selectStockRequest(StockRequestEntity sr) {
    emit(state.copyWith(
      selectedStockRequestId: sr.id,
      selectedStockRequestName: sr.name,
    ));
  }

  void selectScrapReason(ScrapReasonEntity r) {
    emit(state.copyWith(
      selectedReasonId: r.id,
      selectedReasonName: r.name,
    ));
  }

  // ── Line item management ─────────────────────────────────────────────────

  void _addLineItem() {
    final id = 'item_${_itemCounter++}';
    _qtyControllers[id] = TextEditingController(text: '1');
    _reasonControllers[id] = TextEditingController();
    final items = List<ScrapLineItemState>.from(state.lineItems)
      ..add(ScrapLineItemState(localId: id));
    emit(state.copyWith(lineItems: items));
  }

  void addLineItem() => _addLineItem();

  void removeLineItem(String localId) {
    _qtyControllers[localId]?.dispose();
    _qtyControllers.remove(localId);
    _reasonControllers[localId]?.dispose();
    _reasonControllers.remove(localId);
    final items = state.lineItems.where((i) => i.localId != localId).toList();
    emit(state.copyWith(lineItems: items));
  }

  void updateItemLot(String localId, int lotId, String lotName) {
    final items = state.lineItems.map((i) {
      if (i.localId != localId) return i;
      return i.copyWith(lotId: lotId, lotName: lotName);
    }).toList();
    emit(state.copyWith(lineItems: items));
  }

  TextEditingController? qtyController(String localId) =>
      _qtyControllers[localId];
  TextEditingController? reasonController(String localId) =>
      _reasonControllers[localId];

  // ── Build params ─────────────────────────────────────────────────────────

  CreateScrapRequestParams _buildParams() {
    final empId = int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0;
    final deptId = int.tryParse(_sessionStorage.departmentId ?? '0') ?? 0;
    final lineIds = state.lineItems
        .where((i) => i.productId != null)
        .map((i) => ScrapLineItemParams(
              productId: i.productId!,
              productQty:
                  int.tryParse(_qtyControllers[i.localId]?.text ?? '1') ?? 1,
              lotId: i.lotId,
              reason: _reasonControllers[i.localId]?.text.trim() ?? '',
              productName: i.productName,
              lotName: i.lotName,
            ))
        .toList();

    return CreateScrapRequestParams(
      employeeId: empId,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      departmentId: deptId,
      requestDate: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
      custodyIds: state.selectedCustodyIds,
      stockRequestId: state.selectedStockRequestId,
      scrapReasonId: state.selectedReasonId ?? 0,
      requestLineIds: lineIds,
    );
  }

  // ── Create ───────────────────────────────────────────────────────────────

  Future<void> createScrapRequest() async {
    emit(state.copyWith(status: ScrapRequestStatus.createLoading));
    final result =
        await _createScrapRequestUseCase.call(params: _buildParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: ScrapRequestStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: ScrapRequestStatus.createLoaded,
        requestNumber:
            response.requestName ?? response.requestId?.toString() ?? '',
      )),
    );
  }

  // ── Update ───────────────────────────────────────────────────────────────

  Future<void> updateScrapRequest({required int requestId}) async {
    emit(state.copyWith(status: ScrapRequestStatus.createLoading));
    final result = await _updateScrapRequestUseCase.call(
      params: UpdateScrapRequestParams(
        requestId: requestId,
        data: _buildParams(),
      ),
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: ScrapRequestStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: ScrapRequestStatus.createLoaded,
        requestNumber: response.requestName ?? '',
      )),
    );
  }

  // ── Reset ────────────────────────────────────────────────────────────────

  void resetForm() {
    officeIdController.clear();
    todayDateController.clear();
    applicantNameController.clear();
    organizationalUnitController.clear();
    for (final c in _qtyControllers.values) {
      c.dispose();
    }
    for (final c in _reasonControllers.values) {
      c.dispose();
    }
    _qtyControllers.clear();
    _reasonControllers.clear();
    _itemCounter = 0;
    emit(state.copyWith(
      lineItems: [],
      selectedCustodyIds: [],
      selectedStockRequestId: null,
      selectedStockRequestName: '',
      selectedReasonId: null,
      selectedReasonName: '',
    ));
    _addLineItem();
  }

  @override
  Future<void> close() {
    officeIdController.dispose();
    todayDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    for (final c in _qtyControllers.values) {
      c.dispose();
    }
    for (final c in _reasonControllers.values) {
      c.dispose();
    }
    return super.close();
  }
}
