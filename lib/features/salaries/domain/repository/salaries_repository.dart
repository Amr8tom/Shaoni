import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/loan/create_loan_response.dart';
import '../entity/loan/kafeel_employee.dart';
import '../entity/loan/loan_type.dart';
import '../entity/salary_requests/bank.dart';
import '../entity/salary_requests/country.dart';
import '../entity/salary_requests/create_salary_response.dart';
import '../entity/salary_requests/letter_destination.dart';
import '../entity/salary_requests/salary_document_type.dart';
import '../entity/salary_requests/salary_sub_type.dart';
import '../entity/salary_requests/salary_type.dart';
import '../use_cases/loan/create_loan_use_case.dart';
import '../use_cases/loan/edit_loan_use_case.dart';
import '../use_cases/loan/update_loan_use_case.dart';
import '../use_cases/salary_requests/create_salary_use_case.dart';
import '../use_cases/salary_requests/edit_salary_use_case.dart';
import '../use_cases/salary_requests/get_banks_use_case.dart';
import '../use_cases/salary_requests/update_salary_use_case.dart';

abstract class SalariesRepository {
  Future<Either<Failure, CreateSalaryResponse>> createSalaryRequest({
    required CreateSalaryParams params,
  });

  Future<Either<Failure, CreateSalaryResponse>> updateSalaryRequest({
    required UpdateSalaryParams params,
  });

  Future<Either<Failure, CreateSalaryResponse>> editSalaryRequest({
    required EditSalaryParams params,
  });

  Future<Either<Failure, List<SalarySubType>>> getSalarySubTypes();

  Future<Either<Failure, List<SalaryType>>> getSalaryTypes();

  Future<Either<Failure, List<SalaryDocumentType>>> getSalaryDocumentTypes();

  Future<Either<Failure, List<Country>>> getCountries();

  Future<Either<Failure, List<Bank>>> getBanks({
    required GetBanksParams params,
  });

  Future<Either<Failure, List<LetterDestination>>> getLetterDestinations();

  // ── Loan ──
  Future<Either<Failure, List<LoanType>>> getLoanTypes();

  Future<Either<Failure, List<KafeelEmployee>>> getKafeelEmployees();

  Future<Either<Failure, CreateLoanResponse>> createLoanRequest({
    required CreateLoanParams params,
  });

  Future<Either<Failure, CreateLoanResponse>> editLoanRequest({
    required EditLoanParams params,
  });

  Future<Either<Failure, CreateLoanResponse>> updateLoanRequest({
    required UpdateLoanParams params,
  });
}
