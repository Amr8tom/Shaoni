part of 'product_order_cubit.dart';

// ── Line item state ──────────────────────────────────────────────────────────

class LineItemState extends Equatable {
  final String localId;
  final int? categoryId;
  final String categoryName;
  final int? productId;
  final String productName;
  final int qty;
  final String notes;

  const LineItemState({
    required this.localId,
    this.categoryId,
    this.categoryName = '',
    this.productId,
    this.productName = '',
    this.qty = 1,
    this.notes = '',
  });

  LineItemState copyWith({
    int? categoryId,
    String? categoryName,
    int? productId,
    String? productName,
    int? qty,
    String? notes,
    bool clearProduct = false,
  }) {
    return LineItemState(
      localId: localId,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      productId: clearProduct ? null : (productId ?? this.productId),
      productName: clearProduct ? '' : (productName ?? this.productName),
      qty: qty ?? this.qty,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props =>
      [localId, categoryId, categoryName, productId, productName, qty, notes];
}

// ── Status enum ──────────────────────────────────────────────────────────────

enum ProductOrderStatus {
  initial,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  productsLoading,
  createLoading,
  createLoaded,
  createError,
}

extension ProductOrderStatusX on ProductOrderStatus {
  bool get isLoading =>
      this == ProductOrderStatus.lookupsLoading ||
      this == ProductOrderStatus.productsLoading ||
      this == ProductOrderStatus.createLoading;
  bool get isLookupLoaded => this == ProductOrderStatus.lookupsLoaded;
  bool get isError => this == ProductOrderStatus.createError || this == ProductOrderStatus.lookupsError;
  bool get isCreateLoaded => this == ProductOrderStatus.createLoaded;
}

// ── State ────────────────────────────────────────────────────────────────────

class ProductOrderState extends Equatable {
  final ProductOrderStatus status;
  final List<ProductCategory> categories;
  final Map<int, List<OdooProduct>> productsByCategory;
  final List<LineItemState> lineItems;
  final String? errorMessage;
  final String? requestNumber;

  const ProductOrderState({
    this.status = ProductOrderStatus.initial,
    this.categories = const [],
    this.productsByCategory = const {},
    this.lineItems = const [],
    this.errorMessage,
    this.requestNumber,
  });

  ProductOrderState copyWith({
    ProductOrderStatus? status,
    List<ProductCategory>? categories,
    Map<int, List<OdooProduct>>? productsByCategory,
    List<LineItemState>? lineItems,
    String? errorMessage,
    String? requestNumber,
  }) {
    return ProductOrderState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      productsByCategory: productsByCategory ?? this.productsByCategory,
      lineItems: lineItems ?? this.lineItems,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categories,
        productsByCategory,
        lineItems,
        errorMessage,
        requestNumber,
      ];
}
