import '../../../../core/constants/api_constants.dart';
import '../../../../core/dio/dio_helper.dart';
import '../../domain/use_cases/loan/create_loan_use_case.dart';
import '../../domain/use_cases/loan/edit_loan_use_case.dart';
import '../../domain/use_cases/loan/update_loan_use_case.dart';
import '../../domain/use_cases/salary_requests/create_salary_use_case.dart';
import '../../domain/use_cases/salary_requests/edit_salary_use_case.dart';
import '../../domain/use_cases/salary_requests/get_banks_use_case.dart';
import '../../domain/use_cases/salary_requests/update_salary_use_case.dart';
import '../model/loan/create_loan_response_model.dart';
import '../model/loan/loan_type_model.dart';
import '../model/salary_requests/bank_model.dart';
import '../model/salary_requests/country_model.dart';
import '../model/salary_requests/create_salary_response_model.dart';
import '../model/salary_requests/letter_destination_model.dart';
import '../model/salary_requests/salary_document_type_model.dart';
import '../model/salary_requests/salary_sub_type_model.dart';
import '../model/salary_requests/salary_type_model.dart';

abstract class SalariesRemoteDataSource {
  Future<CreateSalaryResponseModel> createSalaryRequest(
      CreateSalaryParams params);
  Future<CreateSalaryResponseModel> updateSalaryRequest(
      UpdateSalaryParams params);
  Future<CreateSalaryResponseModel> editSalaryRequest(EditSalaryParams params);

  Future<List<SalarySubTypeModel>> getSalarySubTypes();
  Future<List<SalaryTypeModel>> getSalaryTypes();
  Future<List<SalaryDocumentTypeModel>> getSalaryDocumentTypes();
  Future<List<CountryModel>> getCountries();
  Future<List<BankModel>> getBanks(GetBanksParams params);
  Future<List<LetterDestinationModel>> getLetterDestinations();

  // ── Loan ──
  Future<List<LoanTypeModel>> getLoanTypes();
  Future<CreateLoanResponseModel> createLoanRequest(CreateLoanParams params);
  Future<CreateLoanResponseModel> editLoanRequest(EditLoanParams params);
  Future<CreateLoanResponseModel> updateLoanRequest(UpdateLoanParams params);
}

class SalariesRemoteDataSourceImpl implements SalariesRemoteDataSource {
  final DioHelper dioHelper;

  SalariesRemoteDataSourceImpl(this.dioHelper);

  @override
  Future<CreateSalaryResponseModel> createSalaryRequest(
      CreateSalaryParams params) async {
    final response = await dioHelper.postData(
      url: URL.createSalaryRequest,
      body: params.toMap(),
    );
    return CreateSalaryResponseModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<CreateSalaryResponseModel> updateSalaryRequest(
      UpdateSalaryParams params) async {
    final response = await dioHelper.putData(
      url: '${URL.updateSalaryRequest}${params.requestId}',
      body: params.toMap(),
    );
    return CreateSalaryResponseModel.fromJson(
        response.data as Map<String, dynamic>);
  }

  @override
  Future<CreateSalaryResponseModel> editSalaryRequest(
      EditSalaryParams params) async {
    final response = await dioHelper.putData(
      url: '${URL.getSalaryRequestEdit}${params.requestId}',
      body: params.toMap(),
    );
    return CreateSalaryResponseModel.fromJson(
        response.data as Map<String, dynamic>);
  }

  @override
  Future<List<SalarySubTypeModel>> getSalarySubTypes() async {
    final response = await dioHelper.getData(url: URL.getSalarySubTypes);
    final data = response is List ? response : response['data'] as List;
    return data
        .map((e) => SalarySubTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SalaryTypeModel>> getSalaryTypes() async {
    final response = await dioHelper.getData(url: URL.getSalaryTypes);
    final data = response is List ? response : response['data'] as List;
    return data
        .map((e) => SalaryTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SalaryDocumentTypeModel>> getSalaryDocumentTypes() async {
    final response = await dioHelper.getData(url: URL.getSalaryDocumentTypes);
    final data = response is List ? response : response['data'] as List;
    return data
        .map((e) => SalaryDocumentTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CountryModel>> getCountries() async {
    final response = await dioHelper.getData(url: URL.getCountries);
    final data = response is List ? response : response['data'] as List;
    return data
        .map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<BankModel>> getBanks(GetBanksParams params) async {
    final response = await dioHelper.getData(
        url: '${URL.getSalaryBanks}${params.countryId}');
    final data = response is List ? response : response['data'] as List;
    return data
        .map((e) => BankModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<LetterDestinationModel>> getLetterDestinations() async {
    final response = await dioHelper.getData(url: URL.getLetterDestinations);
    final data = response is List ? response : response['data'] as List;
    return data
        .map((e) => LetterDestinationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Loan ──
  @override
  Future<List<LoanTypeModel>> getLoanTypes() async {
    final response = await dioHelper.getData(url: URL.getLoanTypes);
    final data = response is List ? response : (response['data'] as List? ?? []);
    return (data)
        .map((e) => LoanTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<CreateLoanResponseModel> createLoanRequest(
      CreateLoanParams params) async {
    final response = await dioHelper.postData(
      url: URL.createLoanRequest,
      body: params.toMap(),
    );
    return CreateLoanResponseModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<CreateLoanResponseModel> editLoanRequest(EditLoanParams params) async {
    final response = await dioHelper.putData(
      url: '${URL.editLoanRequest}${params.requestId}',
      body: params.toMap(),
    );
    return CreateLoanResponseModel.fromJson(
        response.data as Map<String, dynamic>);
  }

  @override
  Future<CreateLoanResponseModel> updateLoanRequest(
      UpdateLoanParams params) async {
    final response = await dioHelper.putData(
      url: '${URL.updateLoanRequest}${params.requestId}',
      body: params.toMap(),
    );
    return CreateLoanResponseModel.fromJson(
        response.data as Map<String, dynamic>);
  }
}
