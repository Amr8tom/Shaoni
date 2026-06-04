import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../model/all_services_model.dart';

abstract class ServicesLocalDataSources {
  /// get all services
  Future<AllServicesModel> getAllServices();

  /// cache all services
  Future<Unit> cacheAllServices(AllServicesModel alServicesModel);
}

class ServicesLocalDataSourcesImp implements ServicesLocalDataSources {
  @override
  Future<Unit> cacheAllServices(AllServicesModel allServicesModel) async {
    final String allServices = jsonEncode(allServicesModel.toJson());
    CacheHelper.putString(key: CacheKeys.allServices, value: allServices);
    return Future.value(unit);
  }

  @override
  Future<AllServicesModel> getAllServices() async {
    final String? allServices =
        CacheHelper.getString(key: CacheKeys.allServices);
    if (allServices != null) {
      return AllServicesModel.fromJson(jsonDecode(allServices));
    } else {
      return Future.value(AllServicesModel(services: []));
    }
  }
}
