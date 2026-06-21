import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/local_storage/session_storage/session_storage.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../domain/entity/loan/kafeel_employee.dart';
import '../../../domain/entity/loan/loan_type.dart';
import '../../../domain/use_cases/loan/create_loan_use_case.dart';
import '../../../domain/use_cases/loan/edit_loan_use_case.dart';
import '../../../domain/use_cases/loan/get_kafeel_employees_use_case.dart';
import '../../../domain/use_cases/loan/get_loan_types_use_case.dart';
import '../../../domain/use_cases/loan/update_loan_use_case.dart';
import 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  final GetLoanTypesUseCase getLoanTypesUseCase;
  final GetKafeelEmployeesUseCase getKafeelEmployeesUseCase;
  final CreateLoanUseCase createLoanUseCase;
  final EditLoanUseCase editLoanUseCase;
  final UpdateLoanUseCase updateLoanUseCase;

  LoanCubit(
    this.getLoanTypesUseCase,
    this.getKafeelEmployeesUseCase,
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

  // kafeel selection
  bool needKafeel = false;
  int? selectedKafeelId;
  String? selectedKafeelName;

  // loaded lookups cache
  List<LoanType> _loanTypes = const [];
  List<KafeelEmployee> _kafeelEmployees = const [];
  bool _hasLookups = false;

  /// Rebuilds the loaded state from the cached lookups + current selections so
  /// the UI always reads selections from state and holds no local widget state.
  void _emitLookups() {
    if (!_hasLookups) return;
    emit(
      LoanLookupsLoaded(
        loanTypes: _loanTypes,
        kafeelEmployees: _kafeelEmployees,
        selectedLoanTypeName: selectedLoanTypeName,
        needKafeel: needKafeel,
        selectedKafeelName: selectedKafeelName,
      ),
    );
  }

  void selectLoanType(LoanType type) {
    selectedLoanTypeId = type.id;
    selectedLoanTypeName = type.name;
    needEmp = type.needEmp;
    _emitLookups();
  }

  void toggleNeedKafeel(bool value) {
    needKafeel = value;
    if (!value) {
      selectedKafeelId = null;
      selectedKafeelName = null;
    }
    _emitLookups();
  }

  void selectKafeelEmployee(int id, String name) {
    selectedKafeelId = id;
    selectedKafeelName = name;
    _emitLookups();
  }

  /// Opens a themed date picker and writes the chosen date into the
  /// first-installment controller. Kept in the cubit so the UI stays declarative.
  Future<void> pickFirstInstallmentDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(firstInstallmentDateController.text) ??
          DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (
          BuildContext context,
          Widget? child,
          ) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorRes.primary,
              onPrimary: ColorRes.white,
              surface: ColorRes.white,
              onSurface: ColorRes.black,
            ),
            textTheme: TextTheme(
              titleLarge: TextStyle(
                color: ColorRes.black,
                fontWeight: FontWeight.bold,
                fontSize: 6,
              ),
            ),
            dialogTheme: DialogTheme(
              backgroundColor: ColorRes.white,
              titleTextStyle: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(
                color: ColorRes.black,
                fontWeight: FontWeight.bold,
                fontSize: 6,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorRes.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      firstInstallmentDateController.text =
          picked.toIso8601String().substring(0, 10);
    }
  }

  void clearData() {
    selectedLoanTypeId = null;
    selectedLoanTypeName = null;
    needEmp = false;
    needKafeel = false;
    selectedKafeelId = null;
    selectedKafeelName = null;
    officeIdController.clear();
    amountController.clear();
    paymentPeriodController.clear();
    firstInstallmentDateController.text =
        DateTime.now().toIso8601String().substring(0, 10);
    noteController.clear();
    _emitLookups();
  }

  Future<void> fetchLookups() async {
    emit(LoanLookupsLoading());

    // Start both requests immediately (parallel) — total wait = max, not sum.
    final loanTypesFuture = getLoanTypesUseCase();
    final kafeelFuture = getKafeelEmployeesUseCase();

    // Await results (both were already in-flight above).
    final loanTypesResult = await loanTypesFuture;
    final kafeelResult = await kafeelFuture;

    loanTypesResult.fold(
      (failure) => emit(LoanLookupsError(message: failure.message ?? '')),
      (loanTypes) {
        _loanTypes = loanTypes;
        _kafeelEmployees = kafeelResult.fold<List<KafeelEmployee>>(
          (_) => const [],
          (list) => list,
        );
        _hasLookups = true;
        _emitLookups();
      },
    );
  }

  Future<void> createRequestSubmit() async {
    emit(CreateLoanLoading());

    final sessionStorage = serviceLocator<SessionStorage>();
    final employeeId = int.tryParse(sessionStorage.employeeId ?? '0') ?? 0;
    final officeId = int.tryParse(officeIdController.text) ?? 0;

    final params = CreateLoanParams(
      employeeId: employeeId,
      officeId: officeId,
      loanType: selectedLoanTypeId ?? 0,
      loanRequestAmount: double.tryParse(amountController.text) ?? 0,
      loanPaymentPeriod: int.tryParse(paymentPeriodController.text) ?? 0,
      firstInstallmentDate: firstInstallmentDateController.text,
      needEmp: needKafeel,
      otherEmployeeId: needKafeel ? selectedKafeelId : null,
    );

    final result = await createLoanUseCase(params: params);

    result.fold(
      (failure) {
        emit(CreateLoanError(message: failure.message ?? ''));
        _emitLookups();
      },
      (response) {
        if (response.success) {
          emit(CreateLoanSuccess(response: response));
        } else {
          emit(CreateLoanError(message: response.message));
          _emitLookups();
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
        _emitLookups();
      },
      (response) {
        if (response.success) {
          emit(CreateLoanSuccess(response: response));
        } else {
          emit(CreateLoanError(message: response.message));
          _emitLookups();
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
      needEmp: needKafeel,
      otherEmployeeId: needKafeel ? selectedKafeelId : null,
    );

    final params = UpdateLoanParams(
      requestId: requestId,
      createParams: createParams,
    );

    final result = await updateLoanUseCase(params: params);

    result.fold(
      (failure) {
        emit(CreateLoanError(message: failure.message ?? ''));
        _emitLookups();
      },
      (response) {
        if (response.success) {
          emit(CreateLoanSuccess(response: response));
        } else {
          emit(CreateLoanError(message: response.message));
          _emitLookups();
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
