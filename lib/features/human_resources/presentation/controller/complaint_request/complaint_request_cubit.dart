import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/local_storage/cache_helper.dart';
import '../../../../../core/local_storage/cache_keys.dart';
import '../../../../../core/utils/usecases/base_usecase.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/complaint_request/complaint_reason.dart';
import '../../../domain/entity/complaint_request/complaint_type.dart';
import '../../../domain/use_cases/complaint_request/create_complaint_request_use_case.dart';
import '../../../domain/use_cases/complaint_request/get_complaint_reasons_use_case.dart';
import '../../../domain/use_cases/complaint_request/get_complaint_types_use_case.dart';

part 'complaint_request_state.dart';

class ComplaintRequestCubit extends Cubit<ComplaintRequestState> {
  final GetComplaintTypesUseCase _getComplaintTypesUseCase;
  final GetComplaintReasonsUseCase _getComplaintReasonsUseCase;
  final CreateComplaintRequestUseCase _createComplaintRequestUseCase;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// ============== applicant + date controllers ==============
  final todayDateController = TextEditingController();
  final hijriDateController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();
  final officeIdController = TextEditingController();

  /// ============== request data controllers ==============
  final complaintTypeController = TextEditingController();
  final complaintReasonController = TextEditingController();
  final complaintDescriptionController = TextEditingController();

  /// ============== attachment controllers ==============
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();

  /// Pre-mapped dropdown items the widget can render directly.
  List<DropdownMenuItem<String>> complaintTypeItems = [];
  List<DropdownMenuItem<String>> complaintReasonItems = [];

  /// Raw lookup lists (kept so we can resolve a selected name back to its
  /// `id` when sending the create request to the API).
  List<ComplaintType> _types = [];
  List<ComplaintReason> _reasons = [];

  ComplaintRequestCubit(
    this._getComplaintTypesUseCase,
    this._getComplaintReasonsUseCase,
    this._createComplaintRequestUseCase,
  ) : super(const ComplaintRequestState()) {
    getComplaintTypes();
    getComplaintReasons();
  }

  Future<void> getComplaintTypes() async {
    emit(state.copyWith(status: ComplaintRequestStatus.typesLoading));
    final result = await _getComplaintTypesUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: ComplaintRequestStatus.typesError,
        errorMessage: failure.message,
      )),
      (types) {
        _types = types;
        complaintTypeItems = types
            .map(
              (t) => DropdownMenuItem<String>(
                value: _localizedName(t.nameAr, t.nameEn),
                child: Text(
                  _localizedName(t.nameAr, t.nameEn),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
            .toList();
        emit(state.copyWith(status: ComplaintRequestStatus.typesLoaded));
      },
    );
  }

  Future<void> getComplaintReasons() async {
    emit(state.copyWith(status: ComplaintRequestStatus.reasonsLoading));
    final result = await _getComplaintReasonsUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: ComplaintRequestStatus.reasonsError,
        errorMessage: failure.message,
      )),
      (reasons) {
        _reasons = reasons;
        complaintReasonItems = reasons
            .map(
              (r) => DropdownMenuItem<String>(
                value: _localizedName(r.nameAr, r.nameEn),
                child: Text(
                  _localizedName(r.nameAr, r.nameEn),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
            .toList();
        emit(state.copyWith(status: ComplaintRequestStatus.reasonsLoaded));
      },
    );
  }

  // -----------------------------------------------------------------
  // Helpers — resolve selected display name back to its API id
  // -----------------------------------------------------------------

  int? get selectedComplaintTypeId {
    if (complaintTypeController.text.isEmpty) return null;
    final selected = _types.where(
      (t) => _localizedName(t.nameAr, t.nameEn) == complaintTypeController.text,
    );
    return selected.isEmpty ? null : selected.first.id;
  }

  int? get selectedComplaintReasonId {
    if (complaintReasonController.text.isEmpty) return null;
    final selected = _reasons.where(
      (r) => _localizedName(r.nameAr, r.nameEn) == complaintReasonController.text,
    );
    return selected.isEmpty ? null : selected.first.id;
  }

  // -----------------------------------------------------------------
  // Submit / reset
  // -----------------------------------------------------------------

  Future<void> createComplaintRequest() async {
    emit(state.copyWith(
      status: ComplaintRequestStatus.createRequestLoading,
    ));
    todayDateController.text = DateTime.now().toString().split(' ').first;
    final result = await _createComplaintRequestUseCase.call(
      params: CreateComplaintRequestParams(
        employeeId:
            int.parse(CacheHelper.getString(key: CacheKeys.employeeId) ?? "1"),
        officeId: officeIdController.text.isEmpty
            ? 0
            : int.tryParse(officeIdController.text),
        complaintTypeId: selectedComplaintTypeId,
        complaintReasonId: selectedComplaintReasonId,
        complaintDescription: complaintDescriptionController.text.isEmpty
            ? ''
            : complaintDescriptionController.text,
        date: todayDateController.text.isEmpty ? null : todayDateController.text,
        attachmentName: attachmentFileNameController.text.isEmpty
            ? ''
            : attachmentFileNameController.text,
        attachment: attachmentFileController.text.isEmpty
            ? ''
            : attachmentFileController.text,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: ComplaintRequestStatus.createRequestError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: ComplaintRequestStatus.createRequestLoaded,
        successMessage: response.message,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  /// Clears every controller — bound to the "delete" floating button.
  void deleteComplaintRequest() {
    todayDateController.clear();
    hijriDateController.clear();
    applicantNameController.clear();
    organizationalUnitController.clear();
    officeIdController.clear();
    complaintTypeController.clear();
    complaintReasonController.clear();
    complaintDescriptionController.clear();
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
    complaintTypeController.dispose();
    complaintReasonController.dispose();
    complaintDescriptionController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
  }
}
