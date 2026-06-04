import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/human_resources/data/model/attendance_record_model.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../model/all_attendance_record_model.dart';
import '../model/permission_time_model.dart';
import '../model/permission_type_model.dart';

abstract class HRServicesLocalDataSources {
  /// cache all exit permission times
  Future<Unit> cacheAllPermissionTimes(
      List<PermissionTimeModel> permissionTimes);

  /// get all exit  permission times
  Future<List<PermissionTimeModel>> getAllPermissionTimes();

  /// cache all exit permission types
  Future<Unit> cacheAllPermissionTypes(
      List<PermissionTypeModel> permissionTypes);

  /// get all exit permission types
  Future<List<PermissionTypeModel>> getAllPermissionTypes();

  /// cache unImplemented attendance records
  Future<Unit> cacheAllAttendanceRecords(
      List<AttendanceRecordModel> attendanceRecords);

  /// get unImplemented attendance records
  Future<AllAttendanceRecordModel> getAllAttendanceRecords();
}

class HRServicesLocalDataSourcesImp implements HRServicesLocalDataSources {
  @override
  Future<Unit> cacheAllPermissionTimes(
      List<PermissionTimeModel> permissionTimes) async {
    final String permissionTimesString =
        jsonEncode(permissionTimes.map((e) => e.toJson()).toList());
    CacheHelper.putString(
        key: CacheKeys.permissionTimes, value: permissionTimesString);
    return Future.value(unit);
  }

  @override
  Future<Unit> cacheAllPermissionTypes(
      List<PermissionTypeModel> permissionTypes) {
    final String permissionTypesString = jsonEncode(permissionTypes);
    CacheHelper.putString(
        key: CacheKeys.permissionTypes, value: permissionTypesString);
    return Future.value(unit);
  }

  @override
  Future<List<PermissionTimeModel>> getAllPermissionTimes() async {
    final String? permissionTimesString =
        CacheHelper.getString(key: CacheKeys.permissionTimes);
    if (permissionTimesString != null) {
      return (jsonDecode(permissionTimesString) as List)
          .map((e) => PermissionTimeModel.fromJson(e))
          .toList();
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<List<PermissionTypeModel>> getAllPermissionTypes() async {
    final String? permissionTypesString =
        CacheHelper.getString(key: CacheKeys.permissionTypes);
    if (permissionTypesString != null) {
      return (jsonDecode(permissionTypesString) as List)
          .map((e) => PermissionTypeModel.fromJson(e))
          .toList();
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<Unit> cacheAllAttendanceRecords(
      List<AttendanceRecordModel> attendanceRecords) async {
    final String attendanceRecordsString =
        jsonEncode(attendanceRecords.map((e) => e.toJson()).toList());
    CacheHelper.putString(
        key: CacheKeys.attendanceRecords, value: attendanceRecordsString);
    return Future.value(unit);
  }

  @override
  Future<AllAttendanceRecordModel> getAllAttendanceRecords() async {
    final String? allRecords =
        CacheHelper.getString(key: CacheKeys.attendanceRecords);
    if (allRecords != null) {
      final Map<String, dynamic> allAttendanceRecordsJson =
          jsonDecode(allRecords);
      return AllAttendanceRecordModel.fromJson(allAttendanceRecordsJson);
    } else {
      throw CacheFailure();
    }
  }
}
