part of 'delete_account_cubit.dart';

final class DeleteAccountState extends Equatable {
  final GeneralStatus status;

  const DeleteAccountState({
    required this.status,
  });

  /// copy with
  DeleteAccountState copyWith({
    GeneralStatus? status,
  }) {
    return DeleteAccountState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
