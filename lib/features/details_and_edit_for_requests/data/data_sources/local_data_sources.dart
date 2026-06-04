import 'dart:convert';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/approve_request_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/all_requests_with_stages.dart';
import '../../../../../core/local_storage/cache_keys.dart';
import '../../domain/entities/request_with_stage.dart';
import '../../domain/use_cases/approve_request_use_case.dart';

abstract class MyRequestsLocalDataSources {
  Future cacheAllMyRequests({required AllRequestsWithStages requests});
  Future<AllRequestsWithStages> getAllMyRequests();
  Future cacheAllMyRequestsByManager({required AllRequestsWithStages requests});
  Future<AllRequestsWithStages> getAllMyRequestsByManager();
  Future cacheRequestDetails({required RequestWithStage requestDetails});
  Future<RequestWithStage> getRequestDetails();
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
  Future cacheAllMyRequestsByManager(
      {required AllRequestsWithStages requests}) async {
    final String myRequestsString = jsonEncode(requests.toJson());
    await CacheHelper.putString(
      key: CacheKeys.myRequestsByManager,
      value: myRequestsString,
    );
  }

  @override
  Future<AllRequestsWithStages> getAllMyRequestsByManager() async {
    final String? myRequestsString =
        await CacheHelper.getString(key: CacheKeys.myRequestsByManager);
    if (myRequestsString != null) {
      return AllRequestsWithStages.fromJson(jsonDecode(myRequestsString));
    }
    throw CacheFailure();
  }

  @override
  Future cacheRequestDetails({required RequestWithStage requestDetails}) async {
    final String requestDetailsString = jsonEncode(requestDetails.toJson());
    await CacheHelper.putString(
      key: CacheKeys.requestDetails,
      value: requestDetailsString,
    );
  }

  @override
  Future<RequestWithStage> getRequestDetails() {
    throw UnimplementedError();
  }
}
