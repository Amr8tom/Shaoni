import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/local_storage/local_storage.dart';
import '../../../../core/local_storage/storage_keys.dart';
import '../model/all_services_model.dart';

abstract class ServicesLocalDataSources {
  /// get all services
  Future<AllServicesModel> getAllServices();

  /// cache all services
  Future<Unit> cacheAllServices(AllServicesModel alServicesModel);
}

class ServicesLocalDataSourcesImp implements ServicesLocalDataSources {
  final LocalStorage _storage;

  const ServicesLocalDataSourcesImp(this._storage);

  @override
  Future<Unit> cacheAllServices(AllServicesModel allServicesModel) async {
    final String allServices = jsonEncode(allServicesModel.toJson());
    await _storage.cacheString(
      key: StorageKeys.allServices.name,
      value: allServices,
    );
    return Future.value(unit);
  }

  @override
  Future<AllServicesModel> getAllServices() async {
    final String? allServices =
        _storage.getString(key: StorageKeys.allServices.name);
    if (allServices != null && allServices.isNotEmpty) {
      return AllServicesModel.fromJson(jsonDecode(allServices));
    } else {
      return Future.value(AllServicesModel(services: []));
    }
  }
}
