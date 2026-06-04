import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/constants/service_codes.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../domain/entity/service.dart';
import '../../domain/entity/services_names.dart';
import '../../domain/use_cases/get_all_permission_services_use_case.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final GetAllPermissionServicesUseCase _getAllServicesUseCase;

  ServicesCubit(this._getAllServicesUseCase) : super(const ServicesState()) {
    getAllServices();
  }

  /// get all services
  Future getAllServices() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _getAllServicesUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: GeneralStatus.error)),
      (services) {
        _divideServicesIntoCategories(services.services);
        emit(
          state.copyWith(
            status: GeneralStatus.success,
            services: services.services,
          ),
        );
      },
    );
  }

  /// Divides services into categories based on ServicesNames lists
  void _divideServicesIntoCategories(List<Service> services) {
    final hrServices = <Service>[];
    final studyServices = <Service>[];
    final purchasesServices = <Service>[];

    for (var service in services) {
      final serviceCode = ServiceCode.fromCode(service.nameEn);

      if (ServicesNames.hrServiceKeys.contains(serviceCode)) {
        hrServices.add(service);
      } else if (ServicesNames.studyServiceKeys.contains(serviceCode)) {
        studyServices.add(service);
      } else if (ServicesNames.productServiceKeys.contains(serviceCode)) {
        purchasesServices.add(service);
      }
    }

    emit(state.copyWith(
      hrServices: hrServices,
      studyServices: studyServices,
      purchasesServices: purchasesServices,
    ));
  }
}
