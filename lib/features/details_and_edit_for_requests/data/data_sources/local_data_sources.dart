import 'dart:convert';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/local_storage.dart';
import 'package:shaoni/core/local_storage/storage_keys.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/all_requests_with_stages_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/request_with_stage_model.dart';

abstract class MyRequestsLocalDataSources {
  Future cacheAllMyRequests({required AllRequestsWithStagesModel requests});
  Future<AllRequestsWithStagesModel> getAllMyRequests();
  Future cacheAllMyRequestsByManager(
      {required AllRequestsWithStagesModel requests});
  Future<AllRequestsWithStagesModel> getAllMyRequestsByManager();
  Future cacheAllMyRequestsByKafeel(
      {required AllRequestsWithStagesModel requests});
  Future<AllRequestsWithStagesModel> getAllMyRequestsByKafeel();
  Future cacheRequestDetails({required RequestWithStageModel requestDetails});
  Future<RequestWithStageModel> getRequestDetails();
}

class MyRequestsLocalDataSourcesImp implements MyRequestsLocalDataSources {
  final LocalStorage _storage;

  const MyRequestsLocalDataSourcesImp(this._storage);

  @override
  Future cacheAllMyRequests(
      {required AllRequestsWithStagesModel requests}) async {
    final String myRequestsString = jsonEncode(requests.toJson());
    await _storage.cacheString(
      key: StorageKeys.myRequests.name,
      value: myRequestsString,
    );
  }

  @override
  Future<AllRequestsWithStagesModel> getAllMyRequests() async {
    final String? myRequestsString =
        _storage.getString(key: StorageKeys.myRequests.name);
    if (myRequestsString != null) {
      return AllRequestsWithStagesModel.fromJson(jsonDecode(myRequestsString));
    }
    throw CacheFailure();
  }

  @override
  Future cacheAllMyRequestsByManager(
      {required AllRequestsWithStagesModel requests}) async {
    final String myRequestsString = jsonEncode(requests.toJson());
    await _storage.cacheString(
      key: StorageKeys.myRequestsByManager.name,
      value: myRequestsString,
    );
  }

  @override
  Future<AllRequestsWithStagesModel> getAllMyRequestsByManager() async {
    final String? myRequestsString =
        _storage.getString(key: StorageKeys.myRequestsByManager.name);
    if (myRequestsString != null) {
      return AllRequestsWithStagesModel.fromJson(jsonDecode(myRequestsString));
    }
    throw CacheFailure();
  }

  @override
  Future cacheAllMyRequestsByKafeel(
      {required AllRequestsWithStagesModel requests}) async {
    final String myRequestsString = jsonEncode(requests.toJson());
    await _storage.cacheString(
      key: StorageKeys.myRequestsByKafeel.name,
      value: myRequestsString,
    );
  }

  @override
  Future<AllRequestsWithStagesModel> getAllMyRequestsByKafeel() async {
    final String? myRequestsString =
        _storage.getString(key: StorageKeys.myRequestsByKafeel.name);
    if (myRequestsString != null) {
      return AllRequestsWithStagesModel.fromJson(jsonDecode(myRequestsString));
    }
    throw CacheFailure();
  }

  @override
  Future cacheRequestDetails(
      {required RequestWithStageModel requestDetails}) async {
    final String requestDetailsString = jsonEncode(requestDetails.toJson());
    await _storage.cacheString(
      key: StorageKeys.requestDetails.name,
      value: requestDetailsString,
    );
  }

  @override
  Future<RequestWithStageModel> getRequestDetails() {
    throw CacheFailure();
  }
}
