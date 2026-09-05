part of 'scrap_request_cubit.dart';

// ── Product option (derived from selected custodies) ─────────────────────────

class ScrapProductOption extends Equatable {
  final int id;
  final String name;

  const ScrapProductOption({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

// ── Line item state ──────────────────────────────────────────────────────────

class ScrapLineItemState extends Equatable {
  final String localId;
  final int? productId;
  final String productName;
  final int? lotId;
  final String lotName;

  const ScrapLineItemState({
    required this.localId,
    this.productId,
    this.productName = '',
    this.lotId,
    this.lotName = '',
  });

  ScrapLineItemState copyWith({
    int? productId,
    String? productName,
    int? lotId,
    String? lotName,
    bool clearLot = false,
    bool clearProduct = false,
  }) {
    return ScrapLineItemState(
      localId: localId,
      productId: clearProduct ? null : (productId ?? this.productId),
      productName: clearProduct ? '' : (productName ?? this.productName),
      lotId: (clearLot || clearProduct) ? null : (lotId ?? this.lotId),
      lotName: (clearLot || clearProduct) ? '' : (lotName ?? this.lotName),
    );
  }

  @override
  List<Object?> get props => [localId, productId, productName, lotId, lotName];
}

// ── Status enum ──────────────────────────────────────────────────────────────

enum ScrapRequestStatus {
  initial,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension ScrapRequestStatusX on ScrapRequestStatus {
  bool get isLoading =>
      this == ScrapRequestStatus.lookupsLoading ||
      this == ScrapRequestStatus.createLoading;
  bool get isError =>
      this == ScrapRequestStatus.createError ||
      this == ScrapRequestStatus.lookupsError;
  bool get isCreateLoaded => this == ScrapRequestStatus.createLoaded;
  bool get isLookupsLoaded => this == ScrapRequestStatus.lookupsLoaded;
}

// ── State ────────────────────────────────────────────────────────────────────

class ScrapRequestState extends Equatable {
  final ScrapRequestStatus status;
  final List<ScrapCustody> custodies;
  final List<StockRequestEntity> stockRequests;
  final List<ScrapReasonEntity> scrapReasons;
  final Map<int, List<ScrapLot>> lots;
  final List<ScrapLineItemState> lineItems;
  final List<int> selectedCustodyIds;
  final int? selectedStockRequestId;
  final String selectedStockRequestName;
  final int? selectedReasonId;
  final String selectedReasonName;
  final String? errorMessage;
  final String? requestNumber;

  const ScrapRequestState({
    this.status = ScrapRequestStatus.initial,
    this.custodies = const [],
    this.stockRequests = const [],
    this.scrapReasons = const [],
    this.lots = const {},
    this.lineItems = const [],
    this.selectedCustodyIds = const [],
    this.selectedStockRequestId,
    this.selectedStockRequestName = '',
    this.selectedReasonId,
    this.selectedReasonName = '',
    this.errorMessage,
    this.requestNumber,
  });

  /// Custodies currently selected in the header multi-select.
  List<ScrapCustody> get selectedCustodies =>
      custodies.where((c) => selectedCustodyIds.contains(c.id)).toList();

  /// Distinct products offered by the selected custodies — the pool the
  /// per-line product dropdown chooses from.
  List<ScrapProductOption> get availableProducts {
    final seen = <int>{};
    final result = <ScrapProductOption>[];
    for (final c in selectedCustodies) {
      if (c.productId != 0 && seen.add(c.productId)) {
        result.add(ScrapProductOption(id: c.productId, name: c.productName));
      }
    }
    return result;
  }

  ScrapRequestState copyWith({
    ScrapRequestStatus? status,
    List<ScrapCustody>? custodies,
    List<StockRequestEntity>? stockRequests,
    List<ScrapReasonEntity>? scrapReasons,
    Map<int, List<ScrapLot>>? lots,
    List<ScrapLineItemState>? lineItems,
    List<int>? selectedCustodyIds,
    int? selectedStockRequestId,
    String? selectedStockRequestName,
    int? selectedReasonId,
    String? selectedReasonName,
    String? errorMessage,
    String? requestNumber,
  }) {
    return ScrapRequestState(
      status: status ?? this.status,
      custodies: custodies ?? this.custodies,
      stockRequests: stockRequests ?? this.stockRequests,
      scrapReasons: scrapReasons ?? this.scrapReasons,
      lots: lots ?? this.lots,
      lineItems: lineItems ?? this.lineItems,
      selectedCustodyIds: selectedCustodyIds ?? this.selectedCustodyIds,
      selectedStockRequestId:
          selectedStockRequestId ?? this.selectedStockRequestId,
      selectedStockRequestName:
          selectedStockRequestName ?? this.selectedStockRequestName,
      selectedReasonId: selectedReasonId ?? this.selectedReasonId,
      selectedReasonName: selectedReasonName ?? this.selectedReasonName,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        custodies,
        stockRequests,
        scrapReasons,
        lots,
        lineItems,
        selectedCustodyIds,
        selectedStockRequestId,
        selectedStockRequestName,
        selectedReasonId,
        selectedReasonName,
        errorMessage,
        requestNumber,
      ];
}
