part of 'delete_account_cubit.dart';

final class DeleteAccountState extends Equatable {
  final GeneralStatus status;

  const DeleteAccountState({
    // this.deleteAccountModel,
    required this.status,
  });

  /// copy with
  DeleteAccountState copyWith({
    DeleteAccountModel? deleteAccountModel,
    GeneralStatus? status,
  }) {
    return DeleteAccountState(
      // deleteAccountModel: deleteAccountModel ?? this.deleteAccountModel,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
