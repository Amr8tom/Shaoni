import 'package:equatable/equatable.dart';
import '../../../domain/entity/loan/create_loan_response.dart';
import '../../../domain/entity/loan/kafeel_employee.dart';
import '../../../domain/entity/loan/loan_type.dart';

abstract class LoanState extends Equatable {
  const LoanState();

  @override
  List<Object?> get props => [];
}

class LoanInitial extends LoanState {}

class LoanLookupsLoading extends LoanState {}

class LoanLookupsLoaded extends LoanState {
  final List<LoanType> loanTypes;
  final List<KafeelEmployee> kafeelEmployees;

  /// Current form selections, surfaced through state so the UI rebuilds on
  /// every change without holding any local widget state.
  final String? selectedLoanTypeName;
  final bool needKafeel;
  final String? selectedKafeelName;

  const LoanLookupsLoaded({
    required this.loanTypes,
    this.kafeelEmployees = const [],
    this.selectedLoanTypeName,
    this.needKafeel = false,
    this.selectedKafeelName,
  });

  @override
  List<Object?> get props => [
        loanTypes,
        kafeelEmployees,
        selectedLoanTypeName,
        needKafeel,
        selectedKafeelName,
      ];
}

class LoanLookupsError extends LoanState {
  final String message;

  const LoanLookupsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateLoanLoading extends LoanState {}

class CreateLoanSuccess extends LoanState {
  final CreateLoanResponse response;

  const CreateLoanSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class CreateLoanError extends LoanState {
  final String message;

  const CreateLoanError({required this.message});

  @override
  List<Object?> get props => [message];
}
