import 'dart:convert';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/features/my-requests/data/models/approve_request_model.dart';
import 'package:shaoni/features/my-requests/domain/entities/all_requests_with_stages.dart';
import '../../../../../core/local_storage/cache_keys.dart';
import '../../domain/use_cases/approve_request_use_case.dart';

abstract class MyRequestsLocalDataSources {
  Future cacheAllMyRequests({required AllRequestsWithStages requests});
  Future<AllRequestsWithStages> getAllMyRequests();
  Future cacheAllMyRequestsByManager({required AllRequestsWithStages requests});
  Future<AllRequestsWithStages> getAllMyRequestsByManager();
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

  @override
  Future cacheAllMyRequestsByManager({required AllRequestsWithStages requests}) async{
    final String myRequestsString = jsonEncode(requests.toJson());
    await CacheHelper.putString(
      key: CacheKeys.myRequestsByManager,
      value: myRequestsString,
    );
  }

  @override
  Future<AllRequestsWithStages> getAllMyRequestsByManager() async{
    final String? myRequestsString =
        await CacheHelper.getString(key: CacheKeys.myRequestsByManager);
    if (myRequestsString != null) {
      return AllRequestsWithStages.fromJson(jsonDecode(myRequestsString));
    }
    throw CacheFailure();
  }


}
