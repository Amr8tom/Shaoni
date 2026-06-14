import 'dart:convert';
import '../../../../core/error/failure.dart';
import '../../../../core/local_storage/local_storage.dart';
import '../model/loan/loan_type_model.dart';
import '../model/salary_requests/bank_model.dart';
import '../model/salary_requests/country_model.dart';
import '../model/salary_requests/letter_destination_model.dart';
import '../model/salary_requests/salary_document_type_model.dart';
import '../model/salary_requests/salary_sub_type_model.dart';
import '../model/salary_requests/salary_type_model.dart';

abstract class SalariesLocalDataSource {
  Future<void> cacheSalarySubTypes(List<SalarySubTypeModel> items);
  Future<List<SalarySubTypeModel>> getCachedSalarySubTypes();

  Future<void> cacheSalaryTypes(List<SalaryTypeModel> items);
  Future<List<SalaryTypeModel>> getCachedSalaryTypes();

  Future<void> cacheSalaryDocumentTypes(List<SalaryDocumentTypeModel> items);
  Future<List<SalaryDocumentTypeModel>> getCachedSalaryDocumentTypes();

  Future<void> cacheCountries(List<CountryModel> items);
  Future<List<CountryModel>> getCachedCountries();

  Future<void> cacheBanks(List<BankModel> items, int countryId);
  Future<List<BankModel>> getCachedBanks(int countryId);

  Future<void> cacheLetterDestinations(List<LetterDestinationModel> items);
  Future<List<LetterDestinationModel>> getCachedLetterDestinations();

  // ── Loan ──
  Future<void> cacheLoanTypes(List<LoanTypeModel> items);
  Future<List<LoanTypeModel>> getCachedLoanTypes();
}

class SalariesLocalDataSourceImpl implements SalariesLocalDataSource {
  final LocalStorage cache;

  SalariesLocalDataSourceImpl(this.cache);

  @override
  Future<void> cacheSalarySubTypes(List<SalarySubTypeModel> items) async {
    final encoded = jsonEncode(
      items.map(SalarySubTypeModel.toJsonFromEntity).toList(),
    );
    await cache.cacheString(key: 'cached_salary_sub_types', value: encoded);
  }

  @override
  Future<List<SalarySubTypeModel>> getCachedSalarySubTypes() async {
    final cached = cache.getString(key: 'cached_salary_sub_types');
    if (cached == null || cached.isEmpty) throw const CacheFailure();

    final decoded = jsonDecode(cached) as List<dynamic>;
    return decoded
        .map((e) => SalarySubTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> cacheSalaryTypes(List<SalaryTypeModel> items) async {
    final encoded = jsonEncode(
      items.map(SalaryTypeModel.toJsonFromEntity).toList(),
    );
    await cache.cacheString(key: 'cached_salary_types', value: encoded);
  }

  @override
  Future<List<SalaryTypeModel>> getCachedSalaryTypes() async {
    final cached = cache.getString(key: 'cached_salary_types');
    if (cached == null || cached.isEmpty) throw const CacheFailure();

    final decoded = jsonDecode(cached) as List<dynamic>;
    return decoded
        .map((e) => SalaryTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> cacheSalaryDocumentTypes(
      List<SalaryDocumentTypeModel> items) async {
    final encoded = jsonEncode(
      items.map(SalaryDocumentTypeModel.toJsonFromEntity).toList(),
    );
    await cache.cacheString(
        key: 'cached_salary_document_types', value: encoded);
  }

  @override
  Future<List<SalaryDocumentTypeModel>> getCachedSalaryDocumentTypes() async {
    final cached = cache.getString(key: 'cached_salary_document_types');
    if (cached == null || cached.isEmpty) throw const CacheFailure();

    final decoded = jsonDecode(cached) as List<dynamic>;
    return decoded
        .map((e) => SalaryDocumentTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> cacheCountries(List<CountryModel> items) async {
    final encoded = jsonEncode(
      items.map(CountryModel.toJsonFromEntity).toList(),
    );
    await cache.cacheString(key: 'cached_salary_countries', value: encoded);
  }

  @override
  Future<List<CountryModel>> getCachedCountries() async {
    final cached = cache.getString(key: 'cached_salary_countries');
    if (cached == null || cached.isEmpty) throw const CacheFailure();

    final decoded = jsonDecode(cached) as List<dynamic>;
    return decoded
        .map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> cacheBanks(List<BankModel> items, int countryId) async {
    final encoded = jsonEncode(
      items.map(BankModel.toJsonFromEntity).toList(),
    );
    await cache.cacheString(
        key: 'cached_salary_banks_$countryId', value: encoded);
  }

  @override
  Future<List<BankModel>> getCachedBanks(int countryId) async {
    final cached = cache.getString(key: 'cached_salary_banks_$countryId');
    if (cached == null || cached.isEmpty) throw const CacheFailure();

    final decoded = jsonDecode(cached) as List<dynamic>;
    return decoded
        .map((e) => BankModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> cacheLetterDestinations(
      List<LetterDestinationModel> items) async {
    final encoded = jsonEncode(
      items.map(LetterDestinationModel.toJsonFromEntity).toList(),
    );
    await cache.cacheString(key: 'cached_letter_destinations', value: encoded);
  }

  @override
  Future<List<LetterDestinationModel>> getCachedLetterDestinations() async {
    final cached = cache.getString(key: 'cached_letter_destinations');
    if (cached == null || cached.isEmpty) throw const CacheFailure();

    final decoded = jsonDecode(cached) as List<dynamic>;
    return decoded
        .map((e) => LetterDestinationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Loan ──
  @override
  Future<void> cacheLoanTypes(List<LoanTypeModel> items) async {
    final encoded = jsonEncode(
      items.map(LoanTypeModel.toJsonFromEntity).toList(),
    );
    await cache.cacheString(key: 'cached_loan_types', value: encoded);
  }

  @override
  Future<List<LoanTypeModel>> getCachedLoanTypes() async {
    final cached = cache.getString(key: 'cached_loan_types');
    if (cached == null || cached.isEmpty) throw const CacheFailure();

    final decoded = jsonDecode(cached) as List<dynamic>;
    return decoded
        .map((e) => LoanTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
