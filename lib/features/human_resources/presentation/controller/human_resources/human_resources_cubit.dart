// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:shaoni/core/utils/enums/general_status.dart';
// import 'package:shaoni/features/human_resources/domain/entity/service.dart';
// import '../../../../../core/utils/usecases/base_usecase.dart';
// import '../../../domain/use_cases/get_all_permission_services_use_case.dart';
//
// part 'human_resources_state.dart';
//
// class HumanResourcesCubit extends Cubit<HumanResourcesState> {
//   final GetAllPermissionServicesUseCase _getAllServicesUseCase;
//
//   HumanResourcesCubit(this._getAllServicesUseCase) : super(HumanResourcesState()) {
//     getAllServices();
//   }
//
//   /// get all services
//   Future getAllServices() async {
//     emit(state.copyWith(status: GeneralStatus.loading));
//     final result = await _getAllServicesUseCase.call(params: NoParams());
//     result.fold(
//       (failure) => emit(state.copyWith(status: GeneralStatus.error)),
//       (services) => emit(
//         state.copyWith(
//           status: GeneralStatus.success,
//           services: services.services,
//         ),
//       ),
//     );
//   }
// }
