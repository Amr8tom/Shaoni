import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shaoni/features/auth/domain/entities/user_entity.dart';

import '../../../../core/utils/enums/general_status.dart';
import '../../../navigation/domain/use_cases/get_user_data_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUserDataUseCase _getUserDataUseCase;

  HomeCubit(this._getUserDataUseCase) : super(const HomeState()) {
  }


}
