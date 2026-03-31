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
    final String UserString = jsonEncode(user.toJson());
    CacheHelper.putString(key: CacheKeys.userData, value: UserString);
  }

  @override
  Future<UserModel> getUserData() async {
    final String UserString =
        CacheHelper.getString(key: CacheKeys.userData) ?? '';
    final Map<String, dynamic> userMap = jsonDecode(UserString);
    final UserModel user = UserModel.fromJson(userMap);
    return user;
  }
}
