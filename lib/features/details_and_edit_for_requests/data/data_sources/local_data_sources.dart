import 'dart:convert';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/all_requests_with_stages_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/request_with_stage_model.dart';
import '../../../../../core/local_storage/cache_keys.dart';

abstract class MyRequestsLocalDataSources {
  Future cacheAllMyRequests({required AllRequestsWithStagesModel requests});
  Future<AllRequestsWithStagesModel> getAllMyRequests();
  Future cacheAllMyRequestsByManager({required AllRequestsWithStagesModel requests});
  Future<AllRequestsWithStagesModel> getAllMyRequestsByManager();
  Future cacheRequestDetails({required RequestWithStageModel requestDetails});
  Future<RequestWithStageModel> getRequestDetails();
}

class MyRequestsLocalDataSourcesImp implements MyRequestsLocalDataSources {
  @override
  Future cacheAllMyRequests({required AllRequestsWithStagesModel requests}) async {
    final String myRequestsString = jsonEncode(requests.toJson());
    await CacheHelper.putString(
      key: CacheKeys.myRequests,
      value: myRequestsString,
    );
  }

  @override
  Future<AllRequestsWithStagesModel> getAllMyRequests() async {
    final String? myRequestsString =
        CacheHelper.getString(key: CacheKeys.myRequests);
    if (myRequestsString != null) {
      return AllRequestsWithStagesModel.fromJson(jsonDecode(myRequestsString));
    }
    throw CacheFailure();
  }

  @override
  Future cacheAllMyRequestsByManager(
      {required AllRequestsWithStagesModel requests}) async {
    final String myRequestsString = jsonEncode(requests.toJson());
    await CacheHelper.putString(
      key: CacheKeys.myRequestsByManager,
      value: myRequestsString,
    );
  }

  @override
  Future<AllRequestsWithStagesModel> getAllMyRequestsByManager() async {
    final String? myRequestsString =
        CacheHelper.getString(key: CacheKeys.myRequestsByManager);
    if (myRequestsString != null) {
      return AllRequestsWithStagesModel.fromJson(jsonDecode(myRequestsString));
    }
    throw CacheFailure();
  }

  @override
  Future cacheRequestDetails({required RequestWithStageModel requestDetails}) async {
    final String requestDetailsString = jsonEncode(requestDetails.toJson());
    await CacheHelper.putString(
      key: CacheKeys.requestDetails,
      value: requestDetailsString,
    );
  }

  @override
  Future<RequestWithStageModel> getRequestDetails() {
    throw CacheFailure();
  }
}
