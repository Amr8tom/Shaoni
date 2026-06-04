import 'dart:convert';

import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../model/user_model.dart';

abstract class NavigationLocalDataSources {
  /// user information
  Future cacheUserData({required UserModel user});

  Future<UserModel> getUserData();
}

class NavigationLocalDataSourcesImp implements NavigationLocalDataSources {
  @override
  Future cacheUserData({required UserModel user}) async {
    final String userString = jsonEncode(user.toJson());
    CacheHelper.putString(key: CacheKeys.userData, value: userString);
  }

  @override
  Future<UserModel> getUserData() async {
    final String userString =
        CacheHelper.getString(key: CacheKeys.userData) ?? '';
    final Map<String, dynamic> userMap = jsonDecode(userString);
    final UserModel user = UserModel.fromJson(userMap);
    return user;
  }
}
