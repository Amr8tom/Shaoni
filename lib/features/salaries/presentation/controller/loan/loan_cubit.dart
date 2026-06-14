import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/local_storage/session_storage/session_storage.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../domain/entity/loan/loan_type.dart';
import '../../../domain/use_cases/loan/create_loan_use_case.dart';
import '../../../domain/use_cases/loan/edit_loan_use_case.dart';
import '../../../domain/use_cases/loan/get_loan_types_use_case.dart';
import '../../../domain/use_cases/loan/update_loan_use_case.dart';
import 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  final GetLoanTypesUseCase getLoanTypesUseCase;
  final CreateLoanUseCase createLoanUseCase;
  final EditLoanUseCase editLoanUseCase;
  final UpdateLoanUseCase updateLoanUseCase;

  LoanCubit(
    this.getLoanTypesUseCase,
    this.createLoanUseCase,
    this.editLoanUseCase,
    this.updateLoanUseCase,
  ) : super(LoanInitial()) {
    firstInstallmentDateController.text =
        DateTime.now().toIso8601String().substring(0, 10);
  }

  static LoanCubit get(context) => BlocProvider.of(context);

  final requestFormKey = GlobalKey<FormState>();

  // controllers
  final officeIdController = TextEditingController();
  final amountController = TextEditingController();
  final paymentPeriodController = TextEditingController();
  final firstInstallmentDateController = TextEditingController();
  final noteController = TextEditingController();

  // selected loan type
  int? selectedLoanTypeId;
  String? selectedLoanTypeName;
  bool needEmp = false;

  // loaded lookups cache
  LoanLookupsLoaded? _lookups;

  void selectLoanType(LoanType type) {
    selectedLoanTypeId = type.id;
    selectedLoanTypeName = type.name;
    needEmp = type.needEmp;
    if (_lookups != null) emit(_lookups!);
  }

  void clearData() {
    selectedLoanTypeId = null;
    selectedLoanTypeName = null;
    needEmp = false;
    officeIdController.clear();
    amountController.clear();
    paymentPeriodController.clear();
    firstInstallmentDateController.text =
        DateTime.now().toIso8601String().substring(0, 10);
    noteController.clear();
    emit(LoanInitial());
    if (_lookups != null) emit(_lookups!);
  }

  Future<void> fetchLookups() async {
    emit(LoanLookupsLoading());

    final result = await getLoanTypesUseCase();

    result.fold(
      (failure) => emit(LoanLookupsError(message: failure.message ?? '')),
      (loanTypes) {
        _lookups = LoanLookupsLoaded(loanTypes: loanTypes);
        emit(_lookups!);
      },
    );
  }

  Future<void> createRequestSubmit() async {
    emit(CreateLoanLoading());

    final sessionStorage = serviceLocator<SessionStorage>();
    final employeeId =
        int.tryParse(sessionStorage.employeeId ?? '0') ?? 0;
    final officeId =
        int.tryParse(officeIdController.text) ?? 0;

    final params = CreateLoanParams(
      employeeId: employeeId,
      officeId: officeId,
      loanType: selectedLoanTypeId ?? 0,
      loanRequestAmount:
          double.tryParse(amountController.text) ?? 0,
      loanPaymentPeriod:
          int.tryParse(paymentPeriodController.text) ?? 0,
      firstInstallmentDate: firstInstallmentDateController.text,
      needEmp: needEmp,
    );

    final result = await createLoanUseCase(params: params);

    result.fold(
      (failure) {
        emit(CreateLoanError(message: failure.message ?? ''));
        if (_lookups != null) emit(_lookups!);
      },
      (response) {
        if (response.success) {
          emit(CreateLoanSuccess(response: response));
        } else {
          emit(CreateLoanError(message: response.message));
          if (_lookups != null) emit(_lookups!);
        }
      },
    );
  }

  Future<void> editRequestSubmit(int requestId) async {
    emit(CreateLoanLoading());

    final params = EditLoanParams(
      requestId: requestId,
      editReasons: noteController.text.trim(),
    );

    final result = await editLoanUseCase(params: params);

    result.fold(
      (failure) {
        emit(CreateLoanError(message: failure.message ?? ''));
        if (_lookups != null) emit(_lookups!);
      },
      (response) {
        if (response.success) {
          emit(CreateLoanSuccess(response: response));
        } else {
          emit(CreateLoanError(message: response.message));
          if (_lookups != null) emit(_lookups!);
        }
      },
    );
  }

  Future<void> updateRequestSubmit(int requestId) async {
    emit(CreateLoanLoading());

    final sessionStorage = serviceLocator<SessionStorage>();
    final employeeId = int.tryParse(sessionStorage.employeeId ?? '0') ?? 0;
    final officeId = int.tryParse(officeIdController.text) ?? 0;

    final createParams = CreateLoanParams(
      employeeId: employeeId,
      officeId: officeId,
      loanType: selectedLoanTypeId ?? 0,
      loanRequestAmount: double.tryParse(amountController.text) ?? 0,
      loanPaymentPeriod: int.tryParse(paymentPeriodController.text) ?? 0,
      firstInstallmentDate: firstInstallmentDateController.text,
      needEmp: needEmp,
    );

    final params = UpdateLoanParams(
      requestId: requestId,
      createParams: createParams,
    );

    final result = await updateLoanUseCase(params: params);

    result.fold(
      (failure) {
        emit(CreateLoanError(message: failure.message ?? ''));
        if (_lookups != null) emit(_lookups!);
      },
      (response) {
        if (response.success) {
          emit(CreateLoanSuccess(response: response));
        } else {
          emit(CreateLoanError(message: response.message));
          if (_lookups != null) emit(_lookups!);
        }
      },
    );
  }

  @override
  Future<void> close() {
    officeIdController.dispose();
    amountController.dispose();
    paymentPeriodController.dispose();
    firstInstallmentDateController.dispose();
    noteController.dispose();
    return super.close();
  }
}
