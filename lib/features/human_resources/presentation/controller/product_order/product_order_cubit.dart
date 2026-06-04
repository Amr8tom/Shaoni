import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/product_order/product.dart';
import 'package:shaoni/features/human_resources/domain/entity/product_order/product_category.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/product_order/get_product_categories_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/product_order/get_products_by_category_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/product_order/create_product_order_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/product_order/update_product_order_use_case.dart';

part 'product_order_state.dart';

class ProductOrderCubit extends Cubit<ProductOrderState> {
  final GetProductCategoriesUseCase _getProductCategoriesUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  final CreateProductOrderUseCase _createProductOrderUseCase;
  final UpdateProductOrderUseCase _updateProductOrderUseCase;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// Applicant & date controllers
  final officeIdController = TextEditingController();
  final todayDateController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();

  /// Request-specific controllers
  final reasonController = TextEditingController();
  final noteController = TextEditingController();

  /// Per-row controllers: keyed by localId
  final Map<String, TextEditingController> _qtyControllers = {};
  final Map<String, TextEditingController> _notesControllers = {};

  int _itemCounter = 0;

  ProductOrderCubit(
    this._getProductCategoriesUseCase,
    this._getProductsByCategoryUseCase,
    this._createProductOrderUseCase,
    this._updateProductOrderUseCase,
  ) : super(const ProductOrderState()) {
    _loadCategories();
    _addLineItem(); // start with one empty row
  }

  // ── Lookups ──────────────────────────────────────────────────────────────

  /// Sentinel cache key used for "All categories" (no category filter).
  static const int _allCategoriesKey = -1;

  Future<void> _loadCategories() async {
    emit(state.copyWith(status: ProductOrderStatus.lookupsLoading));
    final result = await _getProductCategoriesUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: ProductOrderStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (categories) {
        // Prepend "All" so the user can browse the full product catalog.
        final withAll = [
          const ProductCategory(id: _allCategoriesKey, name: 'الكل'),
          ...categories,
        ];
        emit(state.copyWith(
          status: ProductOrderStatus.lookupsLoaded,
          categories: withAll,
        ));
      },
    );
  }

  /// [categoryId] == -1 means "fetch all products" (no filter).
  Future<void> loadProductsForCategory(int categoryId) async {
    // Return cached results if available
    if (state.productsByCategory.containsKey(categoryId)) return;

    emit(state.copyWith(status: ProductOrderStatus.productsLoading));
    final result = await _getProductsByCategoryUseCase.call(
      params: GetProductsByCategoryParams(
        // Pass null to the use-case when the user chose "All".
        categoryId: categoryId == _allCategoriesKey ? null : categoryId,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: ProductOrderStatus.lookupsLoaded,
        errorMessage: failure.message,
      )),
      (products) {
        final updated =
            Map<int, List<OdooProduct>>.from(state.productsByCategory);
        updated[categoryId] = products;
        emit(state.copyWith(
          status: ProductOrderStatus.lookupsLoaded,
          productsByCategory: updated,
        ));
      },
    );
  }

  // ── Line item management ─────────────────────────────────────────────────

  void _addLineItem() {
    final id = 'item_${_itemCounter++}';
    _qtyControllers[id] = TextEditingController(text: '1');
    _notesControllers[id] = TextEditingController();
    final items = List<LineItemState>.from(state.lineItems)
      ..add(LineItemState(localId: id));
    emit(state.copyWith(lineItems: items));
  }

  void addLineItem() => _addLineItem();

  void removeLineItem(String localId) {
    _qtyControllers[localId]?.dispose();
    _qtyControllers.remove(localId);
    _notesControllers[localId]?.dispose();
    _notesControllers.remove(localId);
    final items = state.lineItems.where((i) => i.localId != localId).toList();
    emit(state.copyWith(lineItems: items));
  }

  void updateItemCategory(
      String localId, int? categoryId, String categoryName) {
    if (categoryId != null) {
      loadProductsForCategory(categoryId); // -1 triggers "all" fetch
    }
    final items = state.lineItems.map((i) {
      if (i.localId != localId) return i;
      return i.copyWith(
        categoryId: categoryId,
        categoryName: categoryName,
        clearProduct: true,
      );
    }).toList();
    emit(state.copyWith(lineItems: items));
  }

  void updateItemProduct(String localId, int? productId, String productName) {
    final items = state.lineItems.map((i) {
      if (i.localId != localId) return i;
      return i.copyWith(productId: productId, productName: productName);
    }).toList();
    emit(state.copyWith(lineItems: items));
  }

  TextEditingController? qtyController(String localId) =>
      _qtyControllers[localId];
  TextEditingController? notesController(String localId) =>
      _notesControllers[localId];

  // ── Build params ─────────────────────────────────────────────────────────

  CreateProductOrderParams _buildParams() {
    final empId =
        int.tryParse(CacheHelper.getString(key: CacheKeys.employeeId) ?? '0') ??
            0;
    final lineIds = state.lineItems
        .where((i) => i.productId != null)
        .map((i) => RequestLineItemParams(
              productId: i.productId!,
              productQty:
                  int.tryParse(_qtyControllers[i.localId]?.text ?? '1') ?? 1,
              notes: _notesControllers[i.localId]?.text.trim() ?? '',
            ))
        .toList();

    return CreateProductOrderParams(
      employeeId: empId,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      requestDate: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
      isGift: false,
      reason: reasonController.text.trim(),
      note: noteController.text.trim(),
      type: 'general',
      requestLineIds: lineIds,
    );
  }

  // ── Create ───────────────────────────────────────────────────────────────

  Future<void> createProductOrder() async {
    emit(state.copyWith(status: ProductOrderStatus.createLoading));
    final result =
        await _createProductOrderUseCase.call(params: _buildParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: ProductOrderStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: ProductOrderStatus.createLoaded,
        requestNumber:
            response.requestName ?? response.requestId?.toString() ?? '',
      )),
    );
  }

  // ── Update ───────────────────────────────────────────────────────────────

  Future<void> updateProductOrder({required int requestId}) async {
    emit(state.copyWith(status: ProductOrderStatus.createLoading));
    final result = await _updateProductOrderUseCase.call(
      params: UpdateProductOrderParams(
        requestId: requestId,
        data: _buildParams(),
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: ProductOrderStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: ProductOrderStatus.createLoaded,
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
    reasonController.clear();
    noteController.clear();
    for (final c in _qtyControllers.values) {
      c.dispose();
    }
    for (final c in _notesControllers.values) {
      c.dispose();
    }
    _qtyControllers.clear();
    _notesControllers.clear();
    _itemCounter = 0;
    emit(state.copyWith(lineItems: []));
    _addLineItem();
  }

  @override
  Future<void> close() {
    officeIdController.dispose();
    todayDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    reasonController.dispose();
    noteController.dispose();
    for (final c in _qtyControllers.values) {
      c.dispose();
    }
    for (final c in _notesControllers.values) {
      c.dispose();
    }
    return super.close();
  }
}
