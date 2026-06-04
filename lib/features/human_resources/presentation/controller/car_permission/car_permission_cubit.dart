import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/local_storage/session_storage/session_storage.dart';
import '../../../../../core/utils/usecases/base_usecase.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/car_permission/car_brand.dart';
import '../../../domain/entity/car_permission/car_color.dart';
import '../../../domain/use_cases/car_permission/create_car_permission_use_case.dart';
import '../../../domain/use_cases/car_permission/get_car_brands_use_case.dart';
import '../../../domain/use_cases/car_permission/get_car_colors_use_case.dart';
import '../../../domain/use_cases/car_permission/update_car_permission_use_case.dart';

part 'car_permission_state.dart';

class CarPermissionCubit extends Cubit<CarPermissionState> {
  final GetCarColorsUseCase _getCarColorsUseCase;
  final GetCarBrandsUseCase _getCarBrandsUseCase;
  final CreateCarPermissionUseCase _createCarPermissionUseCase;
  final UpdateCarPermissionUseCase _updateCarPermissionUseCase;
  final SessionStorage _sessionStorage;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// ============== applicant + date controllers ==============
  final todayDateController = TextEditingController();
  final hijriDateController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();
  final officeIdController = TextEditingController();

  /// ============== request data controllers ==============
  final carBrandController = TextEditingController();
  final carColorController = TextEditingController();
  final carNumberController = TextEditingController();

  /// Notes / extra justification.
  final notesController = TextEditingController();

  /// ============== attachment controllers ==============
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();

  /// Pre-mapped dropdown items the widget can render directly.
  List<DropdownMenuItem<String>> carBrandItems = [];
  List<DropdownMenuItem<String>> carColorItems = [];

  /// Raw lookup lists (kept so we can resolve a selected name back to its
  /// `id` when sending the create/update request to the API).
  List<CarBrand> _brands = [];
  List<CarColor> _colors = [];

  CarPermissionCubit(
    this._getCarColorsUseCase,
    this._getCarBrandsUseCase,
    this._createCarPermissionUseCase,
    this._updateCarPermissionUseCase,
    this._sessionStorage,
  ) : super(const CarPermissionState()) {
    getCarBrands();
    getCarColors();
  }

  Future<void> getCarBrands() async {
    emit(state.copyWith(status: CarPermissionStatus.brandsLoading));
    final result = await _getCarBrandsUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: CarPermissionStatus.brandsError,
        errorMessage: failure.message,
      )),
      (brands) {
        _brands = brands;
        carBrandItems = brands
            .map(
              (b) => DropdownMenuItem<String>(
                value: _localizedName(b.nameAr, b.nameEn),
                child: Text(
                  _localizedName(b.nameAr, b.nameEn),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
            .toList();
        emit(state.copyWith(status: CarPermissionStatus.brandsLoaded));
      },
    );
  }

  Future<void> getCarColors() async {
    emit(state.copyWith(status: CarPermissionStatus.colorsLoading));
    final result = await _getCarColorsUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: CarPermissionStatus.colorsError,
        errorMessage: failure.message,
      )),
      (colors) {
        _colors = colors;
        carColorItems = colors
            .map(
              (c) => DropdownMenuItem<String>(
                value: _localizedName(c.nameAr, c.nameEn),
                child: Text(
                  _localizedName(c.nameAr, c.nameEn),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
            .toList();
        emit(state.copyWith(status: CarPermissionStatus.colorsLoaded));
      },
    );
  }

  // -----------------------------------------------------------------
  // Helpers — resolve selected display name back to its API id
  // -----------------------------------------------------------------

  int? get selectedBrandId {
    if (carBrandController.text.isEmpty) return null;
    final selected = _brands.where(
      (b) => _localizedName(b.nameAr, b.nameEn) == carBrandController.text,
    );
    return selected.isEmpty ? null : selected.first.id;
  }

  int? get selectedColorId {
    if (carColorController.text.isEmpty) return null;
    final selected = _colors.where(
      (c) => _localizedName(c.nameAr, c.nameEn) == carColorController.text,
    );
    return selected.isEmpty ? null : selected.first.id;
  }

  // -----------------------------------------------------------------
  // Create
  // -----------------------------------------------------------------

  Future<void> createCarPermissionRequest() async {
    emit(state.copyWith(status: CarPermissionStatus.createRequestLoading));
    todayDateController.text = DateTime.now().toString().split(' ').first;
    final result = await _createCarPermissionUseCase.call(
      params: CreateCarPermissionParams(
        employeeId: int.parse(_sessionStorage.employeeId ?? "1"),
        carBrandId: selectedBrandId,
        carColorId: selectedColorId,
        officeId: officeIdController.text.isEmpty
            ? 0
            : int.tryParse(officeIdController.text),
        carNumber:
            carNumberController.text.isEmpty ? null : carNumberController.text,
        date:
            todayDateController.text.isEmpty ? null : todayDateController.text,
        note: notesController.text.isEmpty ? "" : notesController.text,
        attachments: attachmentFileController.text.isEmpty
            ? ""
            : attachmentFileController.text,
        attachmentsName: attachmentFileNameController.text.isEmpty
            ? ""
            : attachmentFileNameController.text,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: CarPermissionStatus.createRequestError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: CarPermissionStatus.createRequestLoaded,
        successMessage: response.message,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  // -----------------------------------------------------------------
  // Update  (PUT /CarPermission/update/{requestId})
  // -----------------------------------------------------------------

  Future<void> updateCarPermissionRequest({required int requestId}) async {
    emit(state.copyWith(status: CarPermissionStatus.updateRequestLoading));
    todayDateController.text = DateTime.now().toString().split(' ').first;
    final result = await _updateCarPermissionUseCase.call(
      params: UpdateCarPermissionParams(
        requestId: requestId,
        employeeId: int.parse(_sessionStorage.employeeId ?? "1"),
        carBrandId: selectedBrandId,
        carColorId: selectedColorId,
        officeId: officeIdController.text.isEmpty
            ? 0
            : int.tryParse(officeIdController.text),
        carNumber:
            carNumberController.text.isEmpty ? null : carNumberController.text,
        date:
            todayDateController.text.isEmpty ? null : todayDateController.text,
        note: notesController.text.isEmpty ? "" : notesController.text,
        attachments: attachmentFileController.text.isEmpty
            ? ""
            : attachmentFileController.text,
        attachmentsName: attachmentFileNameController.text.isEmpty
            ? ""
            : attachmentFileNameController.text,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: CarPermissionStatus.updateRequestError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: CarPermissionStatus.updateRequestLoaded,
        successMessage: response.message,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  // -----------------------------------------------------------------
  // Reset
  // -----------------------------------------------------------------

  void deleteCarPermissionRequest() {
    todayDateController.clear();
    hijriDateController.clear();
    applicantNameController.clear();
    organizationalUnitController.clear();
    officeIdController.clear();
    carBrandController.clear();
    carColorController.clear();
    carNumberController.clear();
    notesController.clear();
    attachmentFileController.clear();
    attachmentFileNameController.clear();
  }

  String _localizedName(String ar, String en) {
    return S.current.localeee == 'en'
        ? (en.isEmpty ? ar : en)
        : (ar.isEmpty ? en : ar);
  }

  @override
  Future<void> close() {
    todayDateController.dispose();
    hijriDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    officeIdController.dispose();
    carBrandController.dispose();
    carColorController.dispose();
    carNumberController.dispose();
    notesController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
  }
}
