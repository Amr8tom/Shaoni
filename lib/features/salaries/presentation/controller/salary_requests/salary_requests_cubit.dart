import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/local_storage/session_storage/session_storage.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../domain/entity/salary_requests/bank.dart';
import '../../../domain/use_cases/salary_requests/create_salary_use_case.dart';
import '../../../domain/use_cases/salary_requests/edit_salary_use_case.dart';
import '../../../domain/use_cases/salary_requests/get_banks_use_case.dart';
import '../../../domain/use_cases/salary_requests/get_countries_use_case.dart';
import '../../../domain/use_cases/salary_requests/get_letter_destinations_use_case.dart';
import '../../../domain/use_cases/salary_requests/get_salary_document_types_use_case.dart';
import '../../../domain/use_cases/salary_requests/get_salary_sub_types_use_case.dart';
import '../../../domain/use_cases/salary_requests/get_salary_types_use_case.dart';
import '../../../domain/use_cases/salary_requests/update_salary_use_case.dart';
import 'salary_requests_state.dart';

class SalaryRequestsCubit extends Cubit<SalaryRequestsState> {
  final GetSalaryTypesUseCase getSalaryTypesUseCase;
  final GetSalarySubTypesUseCase getSalarySubTypesUseCase;
  final GetSalaryDocumentTypesUseCase getSalaryDocumentTypesUseCase;
  final GetCountriesUseCase getCountriesUseCase;
  final GetBanksUseCase getBanksUseCase;
  final GetLetterDestinationsUseCase getLetterDestinationsUseCase;
  final CreateSalaryUseCase createSalaryUseCase;
  final UpdateSalaryUseCase updateSalaryUseCase;
  final EditSalaryUseCase editSalaryUseCase;

  SalaryRequestsCubit(
    this.getSalaryTypesUseCase,
    this.getSalarySubTypesUseCase,
    this.getSalaryDocumentTypesUseCase,
    this.getCountriesUseCase,
    this.getBanksUseCase,
    this.getLetterDestinationsUseCase,
    this.createSalaryUseCase,
    this.updateSalaryUseCase,
    this.editSalaryUseCase,
  ) : super(SalaryRequestsInitial()) {
    dateController.text = DateTime.now().toIso8601String().substring(0, 10);
  }

  static SalaryRequestsCubit get(context) => BlocProvider.of(context);

  final requestFormKey = GlobalKey<FormState>();

  // Controllers
  final employeeIdController = TextEditingController();
  final dateController = TextEditingController();
  final officeIdController = TextEditingController();
  final requiredDocumentController = TextEditingController();
  final noteController = TextEditingController();

  final countryOfBankController = TextEditingController();
  final bankIdController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ibanController = TextEditingController();
  final ibanAttachmentController = TextEditingController();
  final disclaimerAttachmentController = TextEditingController();

  final salaryTypeController = TextEditingController();
  final destinationOfLettersIdController = TextEditingController();
  final reasonController = TextEditingController();

  final attachmentFileController = TextEditingController();

  String? selectedSalaryRequestType;

  SalaryRequestsLookupsLoaded? lookups;
  List<Bank> banks = [];

  void setSalaryRequestType(String code) {
    selectedSalaryRequestType = code;
    emit(SalaryRequestsInitial());
    emit(SalaryRequestsLookupsLoaded(
      salaryTypes: lookups?.salaryTypes ?? [],
      salarySubTypes: lookups?.salarySubTypes ?? [],
      salaryDocumentTypes: lookups?.salaryDocumentTypes ?? [],
      countries: lookups?.countries ?? [],
      letterDestinations: lookups?.letterDestinations ?? [],
    ));
  }

  void clearData() {
    selectedSalaryRequestType = null;
    employeeIdController.clear();
    dateController.clear();
    officeIdController.clear();
    requiredDocumentController.clear();
    noteController.clear();
    countryOfBankController.clear();
    bankIdController.clear();
    accountNumberController.clear();
    ibanController.clear();
    ibanAttachmentController.clear();
    disclaimerAttachmentController.clear();
    salaryTypeController.clear();
    destinationOfLettersIdController.clear();
    reasonController.clear();
    attachmentFileController.clear();
    emit(SalaryRequestsInitial());
    if (lookups != null) emit(lookups!);
  }

  Future<void> fetchLookups() async {
    emit(SalaryRequestsLoading());

    final typesResult = await getSalaryTypesUseCase();
    final subTypesResult = await getSalarySubTypesUseCase();
    final documentTypesResult = await getSalaryDocumentTypesUseCase();
    final countriesResult = await getCountriesUseCase();
    final destinationsResult = await getLetterDestinationsUseCase();

    typesResult.fold(
      (failure) => emit(SalaryRequestsError(message: failure.message ?? '')),
      (types) {
        subTypesResult.fold(
          (failure) =>
              emit(SalaryRequestsError(message: failure.message ?? '')),
          (subTypes) {
            documentTypesResult.fold(
              (failure) =>
                  emit(SalaryRequestsError(message: failure.message ?? '')),
              (documentTypes) {
                countriesResult.fold(
                  (failure) =>
                      emit(SalaryRequestsError(message: failure.message ?? '')),
                  (countries) {
                    destinationsResult.fold(
                      (failure) => emit(
                          SalaryRequestsError(message: failure.message ?? '')),
                      (destinations) {
                        lookups = SalaryRequestsLookupsLoaded(
                          salaryTypes: types,
                          salarySubTypes: subTypes,
                          salaryDocumentTypes: documentTypes,
                          countries: countries,
                          letterDestinations: destinations,
                        );
                        emit(lookups!);
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> fetchBanks(int countryId) async {
    emit(SalaryRequestsBanksLoading());
    final result =
        await getBanksUseCase(params: GetBanksParams(countryId: countryId));
    result.fold(
      (failure) =>
          emit(SalaryRequestsBanksError(message: failure.message ?? '')),
      (loadedBanks) {
        banks = loadedBanks;
        emit(SalaryRequestsBanksLoaded(banks: loadedBanks));
        if (lookups != null) {
          emit(lookups!); // return to previous state after loading
        }
      },
    );
  }

  CreateSalaryParams _buildParams() {
    final SessionStorage sessionStorage = serviceLocator<SessionStorage>();
    return CreateSalaryParams(
      employeeId: int.tryParse(sessionStorage.employeeId ?? '0') ?? 0,
      date: dateController.text,
      salaryRequest: selectedSalaryRequestType ?? '',
      officeId: int.tryParse(officeIdController.text) ?? 0,
      requiredDocument: requiredDocumentController.text,
      note: noteController.text,
      countryOfBank: int.tryParse(countryOfBankController.text),
      bankId: int.tryParse(bankIdController.text),
      accountNumber: accountNumberController.text,
      iban: ibanController.text,
      ibanAttachment: ibanAttachmentController.text,
      disclaimerAttachment: disclaimerAttachmentController.text,
      salaryType: salaryTypeController.text,
      destinationOfLettersId:
          int.tryParse(destinationOfLettersIdController.text),
      reason: reasonController.text,
    );
  }

  Future<void> createRequestSubmit() async {
    emit(CreateSalaryRequestLoading());
    final result = await createSalaryUseCase(params: _buildParams());
    result.fold(
      (failure) {
        emit(CreateSalaryRequestError(message: failure.message ?? ''));
        if (lookups != null) emit(lookups!);
      },
      (response) => emit(CreateSalaryRequestSuccess(response: response)),
    );
  }

  Future<void> updateRequestSubmit({required int requestId}) async {
    emit(CreateSalaryRequestLoading());
    final result = await updateSalaryUseCase(
      params: UpdateSalaryParams(
          requestId: requestId, createParams: _buildParams()),
    );
    result.fold(
      (failure) {
        emit(CreateSalaryRequestError(message: failure.message ?? ''));
        if (lookups != null) emit(lookups!);
      },
      (response) => emit(CreateSalaryRequestSuccess(response: response)),
    );
  }

  Future<void> editRequestSubmit({required int requestId}) async {
    emit(CreateSalaryRequestLoading());
    final result = await editSalaryUseCase(
      params: EditSalaryParams(
          requestId: requestId, editReasons: noteController.text), // Example
    );
    result.fold(
      (failure) {
        emit(CreateSalaryRequestError(message: failure.message ?? ''));
        if (lookups != null) emit(lookups!);
      },
      (response) => emit(CreateSalaryRequestSuccess(response: response)),
    );
  }
}
