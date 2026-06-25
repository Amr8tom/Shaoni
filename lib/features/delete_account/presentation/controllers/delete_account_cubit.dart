import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/local_storage/session_storage/session_storage.dart';
import '../../../../core/utils/enums/general_status.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../domain/usecases/delete_account_use_case.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final DeleteAccountUseCase _deleteAccountUseCase;
  final SessionStorage _sessionStorage;

  DeleteAccountCubit(this._deleteAccountUseCase, this._sessionStorage)
      : super(DeleteAccountState(status: GeneralStatus.initialized));

  Future deleteAccount() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _deleteAccountUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(state.copyWith(status: GeneralStatus.error));
      },
      (deleteAccountModel) async {
        await _sessionStorage.clearSession();
        if (isClosed) return;
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
