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
      : super(const HomeState(requestsStatus: {})) {
    getAllStatusCounts();
  }

  Future getAllStatusCounts() async {
    emit(state.copyWith(status: GeneralStatus.loading, requestsStatus: {}));
    final result = await _allStatusCountsUseCase.call(params: NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(status: GeneralStatus.error));
      },
      (data) {
        final Map<String, String> updatedStatus = {};
        for (var element in data) {
          if (element.statusCounts != null) {
            for (var e in element.statusCounts!) {
              final name = e.nameEn?.trim();
              if (name != null && name.isNotEmpty) {
                print(name);
                final currentCount = int.tryParse(updatedStatus[name] ?? '0') ?? 0;
                final newCount = (e.count ?? 0) + currentCount;
                updatedStatus[name] = newCount.toString();
              }
            }
          }
        }
        emit(state.copyWith(
          status: GeneralStatus.success,
          allStatusCounts: data,
          requestsStatus: updatedStatus,
        ));
      },
    );
  }
}
