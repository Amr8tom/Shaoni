import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/utils/enums/general_status.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../data/models/delete_account_model.dart';
import '../../domain/usecases/delete_account_use_case.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final DeleteAccountUseCase _deleteAccountUseCase;

  DeleteAccountCubit(this._deleteAccountUseCase)
    : super(DeleteAccountState(status: GeneralStatus.initialized));

  Future deleteAccount() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _deleteAccountUseCase.call(params: NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(status: GeneralStatus.error));
      },
      (deleteAccountModel) {
        CacheHelper.clearShared();
        emit(
          state.copyWith(
            status: GeneralStatus.success,
            // deleteAccountModel: deleteAccountModel,
          ),
        );
      },
    );
  }
}
