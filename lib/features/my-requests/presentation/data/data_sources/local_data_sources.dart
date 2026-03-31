import 'dart:convert';

import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/features/my-requests/domain/entities/all_requests_with_stages.dart';

import '../../../../../core/local_storage/cache_keys.dart';
import '../../../domain/use_cases/get_all_user_requests_use_case.dart';

abstract class MyRequestsLocalDataSources {
  Future cacheAllMyRequests({required AllRequestsWithStages requests});

  Future<AllRequestsWithStages> getAllMyRequests();
}

class MyRequestsLocalDataSourcesImp implements MyRequestsLocalDataSources {
  @override
  Future cacheAllMyRequests({required AllRequestsWithStages requests}) async {
    final String myRequestsString = jsonEncode(requests.toJson());
    await CacheHelper.putString(
      key: CacheKeys.myRequests,
      value: myRequestsString,
    );
  }

  @override
  Future<AllRequestsWithStages> getAllMyRequests() async {
    final String? myRequestsString =
    await CacheHelper.getString(key: CacheKeys.myRequests);
    if (myRequestsString != null) {
      return AllRequestsWithStages.fromJson(jsonDecode(myRequestsString));
    }
    throw CacheFailure();
  }
}
