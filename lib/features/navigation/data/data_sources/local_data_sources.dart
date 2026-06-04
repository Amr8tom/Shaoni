import 'dart:convert';

import '../../../../core/local_storage/local_storage.dart';
import '../../../../core/local_storage/storage_keys.dart';
import '../model/user_model.dart';

abstract class NavigationLocalDataSources {
  /// user information
  Future cacheUserData({required UserModel user});

  Future<UserModel> getUserData();
}

class NavigationLocalDataSourcesImp implements NavigationLocalDataSources {
  final LocalStorage _storage;

  const NavigationLocalDataSourcesImp(this._storage);

  @override
  Future cacheUserData({required UserModel user}) async {
    final String userString = jsonEncode(user.toJson());
    await _storage.cacheString(
      key: StorageKeys.userData.name,
      value: userString,
    );
  }

  @override
  Future<UserModel> getUserData() async {
    final String userString =
        _storage.getString(key: StorageKeys.userData.name) ?? '';
    final Map<String, dynamic> userMap = jsonDecode(userString);
    final UserModel user = UserModel.fromJson(userMap);
    return user;
  }
}
