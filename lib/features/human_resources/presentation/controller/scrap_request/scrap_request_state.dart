part of 'scrap_request_cubit.dart';

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
  }) {
    return ScrapLineItemState(
      localId: localId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      lotId: clearLot ? null : (lotId ?? this.lotId),
      lotName: clearLot ? '' : (lotName ?? this.lotName),
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
  final int? selectedCustodyId;
  final String selectedCustodyName;
  final int? custodyProductId;
  final String custodyProductName;
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
    this.selectedCustodyId,
    this.selectedCustodyName = '',
    this.custodyProductId,
    this.custodyProductName = '',
    this.selectedStockRequestId,
    this.selectedStockRequestName = '',
    this.selectedReasonId,
    this.selectedReasonName = '',
    this.errorMessage,
    this.requestNumber,
  });

  ScrapRequestState copyWith({
    ScrapRequestStatus? status,
    List<ScrapCustody>? custodies,
    List<StockRequestEntity>? stockRequests,
    List<ScrapReasonEntity>? scrapReasons,
    Map<int, List<ScrapLot>>? lots,
    List<ScrapLineItemState>? lineItems,
    int? selectedCustodyId,
    String? selectedCustodyName,
    int? custodyProductId,
    String? custodyProductName,
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
      selectedCustodyId: selectedCustodyId ?? this.selectedCustodyId,
      selectedCustodyName: selectedCustodyName ?? this.selectedCustodyName,
      custodyProductId: custodyProductId ?? this.custodyProductId,
      custodyProductName: custodyProductName ?? this.custodyProductName,
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
        selectedCustodyId,
        selectedCustodyName,
        custodyProductId,
        custodyProductName,
        selectedStockRequestId,
        selectedStockRequestName,
        selectedReasonId,
        selectedReasonName,
        errorMessage,
        requestNumber,
      ];
}
