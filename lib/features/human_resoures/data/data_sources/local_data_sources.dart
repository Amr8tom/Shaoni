import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../model/all_services_model.dart';
import '../model/permission_time_model.dart';
import '../model/permission_type_model.dart';

abstract class HRServicesLocalDataSources{
  /// get all services
  Future<AllServicesModel> getAllServices();
  /// cache all services
  Future<Unit> cacheAllServices(AllServicesModel allServicesModel);
  /// cache all permission times
  Future<Unit> cacheAllPermissionTimes(List<PermissionTimeModel> permissionTimes);
  /// get all permission times
 Future<List<PermissionTimeModel>> getAllPermissionTimes();
 /// cache all permission types
  Future<Unit> cacheAllPermissionTypes(List<PermissionTypeModel> permissionTypes);
  /// get all permission types
  Future<List<PermissionTypeModel>> getAllPermissionTypes();
}
class HRServicesLocalDataSourcesImp implements HRServicesLocalDataSources{

  @override
  Future<Unit> cacheAllPermissionTimes(List<PermissionTimeModel> permissionTimes) async{
    final String PermisstionTimes =jsonEncode(permissionTimes.map((e) => e.toJson()).toList());
    CacheHelper.putString(key: CacheKeys.permissionTimes, value: PermisstionTimes);
    return Future.value(unit);
  }

  @override
  Future<Unit> cacheAllPermissionTypes(List<PermissionTypeModel> permissionTypes) {
    final String PermisstionTypes =jsonEncode(permissionTypes);
    CacheHelper.putString(key: CacheKeys.permissionTypes, value: PermisstionTypes);
    return Future.value(unit);
  }

  @override
  Future<Unit> cacheAllServices(AllServicesModel allServicesModel) async{
    final String allServices =jsonEncode(allServicesModel.toJson());
    CacheHelper.putString(key: CacheKeys.allServices, value: allServices);
    return Future.value(unit);
  }

  @override
  Future<List<PermissionTimeModel>> getAllPermissionTimes() async{
    final String? PermisstionTimes =CacheHelper.getString(key: CacheKeys.permissionTimes);
    if(PermisstionTimes != null){
      return (jsonDecode(PermisstionTimes) as List)
          .map((e) => PermissionTimeModel.fromJson(e))
          .toList();
    }else{
      return Future.value([]);
    }

  }

  @override
  Future<List<PermissionTypeModel>> getAllPermissionTypes() async{
    final String? PermisstionTypes =CacheHelper.getString(key: CacheKeys.permissionTypes);
    if(PermisstionTypes != null){
      return (jsonDecode(PermisstionTypes) as List)
          .map((e) => PermissionTypeModel.fromJson(e))
          .toList();
    }else{
      return Future.value([]);
    }

  }

  @override
  Future<AllServicesModel> getAllServices() async {
    final String? allServices =CacheHelper.getString(key: CacheKeys.allServices);
    if(allServices != null){
      return AllServicesModel.fromJson(jsonDecode(allServices));
    }else{
      return Future.value(AllServicesModel(services: []));
    }

  }
  }