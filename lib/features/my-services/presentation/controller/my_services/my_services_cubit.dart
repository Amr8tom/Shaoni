import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import 'package:shaoni/features/my-services/domain/entity/service.dart';
import 'package:shaoni/features/my-services/domain/use_cases/get_all_permission_services_use_case.dart';

import '../../../../../core/utils/usecases/base_usecase.dart';

part 'my_services_state.dart';

class MyServicesCubit extends Cubit<MyServicesState> {
  final GetAllPermissionServicesUseCase _getAllServicesUseCase;

  MyServicesCubit(this._getAllServicesUseCase) : super(MyServicesState()) {
    getAllServices();
  }

  /// get all services
  Future getAllServices() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _getAllServicesUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: GeneralStatus.error)),
      (services) => emit(
        state.copyWith(
          status: GeneralStatus.success,
          services: services.services,
        ),
      ),
    );
  }
}
