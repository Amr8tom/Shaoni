import 'package:equatable/equatable.dart';
import '../../../domain/entity/salary_requests/bank.dart';
import '../../../domain/entity/salary_requests/country.dart';
import '../../../domain/entity/salary_requests/create_salary_response.dart';
import '../../../domain/entity/salary_requests/letter_destination.dart';
import '../../../domain/entity/salary_requests/salary_document_type.dart';
import '../../../domain/entity/salary_requests/salary_sub_type.dart';
import '../../../domain/entity/salary_requests/salary_type.dart';

abstract class SalaryRequestsState extends Equatable {
  const SalaryRequestsState();

  @override
  List<Object?> get props => [];
}

class SalaryRequestsInitial extends SalaryRequestsState {}

class SalaryRequestsLoading extends SalaryRequestsState {}

class SalaryRequestsLookupsLoaded extends SalaryRequestsState {
  final List<SalaryType> salaryTypes;
  final List<SalarySubType> salarySubTypes;
  final List<SalaryDocumentType> salaryDocumentTypes;
  final List<Country> countries;
  final List<LetterDestination> letterDestinations;

  const SalaryRequestsLookupsLoaded({
    required this.salaryTypes,
    required this.salarySubTypes,
    required this.salaryDocumentTypes,
    required this.countries,
    required this.letterDestinations,
  });

  @override
  List<Object?> get props => [
        salaryTypes,
        salarySubTypes,
        salaryDocumentTypes,
        countries,
        letterDestinations,
      ];
}

class SalaryRequestsError extends SalaryRequestsState {
  final String message;

  const SalaryRequestsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SalaryRequestsBanksLoading extends SalaryRequestsState {}

class SalaryRequestsBanksLoaded extends SalaryRequestsState {
  final List<Bank> banks;

  const SalaryRequestsBanksLoaded({required this.banks});

  @override
  List<Object?> get props => [banks];
}

class SalaryRequestsBanksError extends SalaryRequestsState {
  final String message;

  const SalaryRequestsBanksError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateSalaryRequestLoading extends SalaryRequestsState {}

class CreateSalaryRequestSuccess extends SalaryRequestsState {
  final CreateSalaryResponse response;

  const CreateSalaryRequestSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class CreateSalaryRequestError extends SalaryRequestsState {
  final String message;

  const CreateSalaryRequestError({required this.message});

  @override
  List<Object?> get props => [message];
}
