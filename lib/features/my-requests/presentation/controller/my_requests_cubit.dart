import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/get_all_user_requests_use_case.dart';

import '../../../../core/local_storage/cache_keys.dart';
import '../../domain/entities/all_requests_with_stages.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  GetAllUserRequestsUseCase _getAllUserRequestsUseCase;

  MyRequestsCubit(this._getAllUserRequestsUseCase)
      : super(const MyRequestsState()){

    print("============= employeeId =============");
    print(CacheHelper.getString(key: CacheKeys.employeeId));
    getAllUserRequests(employeeId: int.parse(CacheHelper.getString(key: CacheKeys.employeeId)??''));
  }

  /// getAllUserRequests
  Future getAllUserRequests({required int employeeId}) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _getAllUserRequestsUseCase.call(
      params: GetAllUserRequestsParams(
          // userId: int.parse(CacheHelper.getString(key: CacheKeys.employeeId)??''),
          userId: employeeId,
          requestIds: [0],
          pageNumber: 1,
          pageSize: 15),
    );
    result.fold(
          (failure) => emit(state.copyWith(status: GeneralStatus.error)),
          (requests) =>
          emit(
            state.copyWith(
              status: GeneralStatus.success,
              requests:requests,
            ),
          ),
    );
  }


}
