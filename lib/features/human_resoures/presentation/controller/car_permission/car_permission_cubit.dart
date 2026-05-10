import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/local_storage/cache_helper.dart';
import '../../../../../core/local_storage/cache_keys.dart';
import '../../../../../core/utils/usecases/base_usecase.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/car_permission/car_brand.dart';
import '../../../domain/entity/car_permission/car_color.dart';
import '../../../domain/use_cases/car_permission/create_car_permission_use_case.dart';
import '../../../domain/use_cases/car_permission/get_car_brands_use_case.dart';
import '../../../domain/use_cases/car_permission/get_car_colors_use_case.dart';

part 'car_permission_state.dart';

class CarPermissionCubit extends Cubit<CarPermissionState> {
  final GetCarColorsUseCase _getCarColorsUseCase;
  final GetCarBrandsUseCase _getCarBrandsUseCase;
  final CreateCarPermissionUseCase _createCarPermissionUseCase;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// ============== applicant + date controllers ==============
  final TextEditingController todayDateController = TextEditingController();
  final TextEditingController hijriDateController = TextEditingController();
  final TextEditingController applicantNameController =
      TextEditingController();
  final TextEditingController organizationalUnitController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();

  /// ============== request data controllers ==============
  final TextEditingController carBrandController = TextEditingController();
  final TextEditingController carColorController = TextEditingController();
  final TextEditingController carNumberController = TextEditingController();

  /// Notes / extra justification (kept for parity with the other forms).
  final TextEditingController notesController = TextEditingController();

  /// ============== attachment controllers (same as Study) ==============
  final TextEditingController attachmentFileController =
      TextEditingController();
  final TextEditingController attachmentFileNameController =
      TextEditingController();

  /// Pre-mapped dropdown items the widget can render directly.
  List<DropdownMenuItem<String>> carBrandItems = [];
  List<DropdownMenuItem<String>> carColorItems = [];

  /// Raw lookup lists (kept around so we can resolve a selected name back
  /// to its `id` when sending the create request to the API).
  List<CarBrand> _brands = [];
  List<CarColor> _colors = [];

  CarPermissionCubit(
    this._getCarColorsUseCase,
    this._getCarBrandsUseCase,
    this._createCarPermissionUseCase,
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
  // Helpers used by the screen on submit (resolve name → id for the API)
  // -----------------------------------------------------------------

  int? get selectedBrandId {
    if (carBrandController.text.isEmpty) return null;
    final selected = _brands.where(
      (b) =>
          _localizedName(b.nameAr, b.nameEn) == carBrandController.text,
    );
    return selected.isEmpty ? null : selected.first.id;
  }

  int? get selectedColorId {
    if (carColorController.text.isEmpty) return null;
    final selected = _colors.where(
      (c) =>
          _localizedName(c.nameAr, c.nameEn) == carColorController.text,
    );
    return selected.isEmpty ? null : selected.first.id;
  }

  // -----------------------------------------------------------------
  // Submit / reset
  // -----------------------------------------------------------------

  /// Placeholder until the create-car-permission use case + endpoint
  /// payload are agreed with the backend. The shape mirrors the create
  /// attendance flow (loading → loaded / error).
  Future<void> createCarPermissionRequest() async {
    emit(state.copyWith(
      status: CarPermissionStatus.createRequestLoading,
    ));
    todayDateController.text=DateTime.now().toString().split(' ').first;
    final result =await _createCarPermissionUseCase.call(
      params: CreateCarPermissionParams(
        employeeId: int.parse(CacheHelper.getString(key: CacheKeys.employeeId) ?? "1" ),
        carBrandId: selectedBrandId,
        carColorId: selectedColorId,
        carNumber: carNumberController.text.isEmpty
            ? null
            : carNumberController.text,
        date: todayDateController.text.isEmpty
            ? null
            : todayDateController.text,
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

  /// Clears every controller — bound to the "delete" floating button.
  void deleteCarPermissionRequest() {
    todayDateController.clear();
    hijriDateController.clear();
    applicantNameController.clear();
    organizationalUnitController.clear();
    locationController.clear();
    carBrandController.clear();
    carColorController.clear();
    carNumberController.clear();
    notesController.clear();
    attachmentFileController.clear();
    attachmentFileNameController.clear();
  }

  String _localizedName(String ar, String en) {
    return S.current.localeee == 'en' ? (en.isEmpty ? ar : en) : (ar.isEmpty ? en : ar);
  }

  @override
  Future<void> close() {
    todayDateController.dispose();
    hijriDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    locationController.dispose();
    carBrandController.dispose();
    carColorController.dispose();
    carNumberController.dispose();
    notesController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
  }
}
