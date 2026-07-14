import 'dart:convert';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/local_storage.dart';
import 'package:shaoni/core/local_storage/storage_keys.dart';
import 'package:shaoni/features/home/data/model/annual_leave_balance_model.dart';

abstract class HomeLocalDataSources {
  Future cacheAnnualLeaveBalance({required AnnualLeaveBalanceModel balance});
  Future<AnnualLeaveBalanceModel> getAnnualLeaveBalance();
}

class HomeLocalDataSourcesImp implements HomeLocalDataSources {
  final LocalStorage _storage;

  const HomeLocalDataSourcesImp(this._storage);

  @override
  Future cacheAnnualLeaveBalance({
    required AnnualLeaveBalanceModel balance,
  }) async {
    final String encoded = jsonEncode(balance.toJson());
    await _storage.cacheString(
      key: StorageKeys.annualLeaveBalance.name,
      value: encoded,
    );
  }

  @override
  Future<AnnualLeaveBalanceModel> getAnnualLeaveBalance() async {
    final String? cached =
        _storage.getString(key: StorageKeys.annualLeaveBalance.name);
    if (cached != null) {
      return AnnualLeaveBalanceModel.fromJson(jsonDecode(cached));
    }
    throw CacheFailure();
  }
}
