import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shaoni/features/auth/domain/entities/user_entity.dart';
import 'package:shaoni/features/home/domain/use_cases/get_all_status_counts_use_case.dart';

import '../../../../core/utils/enums/general_status.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../../navigation/domain/use_cases/get_user_data_use_case.dart';
import '../../domain/entities/all_status_count.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final GetAllStatusCountsUseCase _allStatusCountsUseCase;

  HomeCubit(this._getUserDataUseCase, this._allStatusCountsUseCase)
      : super(const HomeState());

  Future getAllStatusCounts() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _allStatusCountsUseCase.call(params: NoParams());
    result.fold(
          (failure) {
        emit(state.copyWith(status: GeneralStatus.error));
      },
          (data) {
        emit(state.copyWith(
            status: GeneralStatus.success, allStatusCounts: data));
      },
    );
  }
}
