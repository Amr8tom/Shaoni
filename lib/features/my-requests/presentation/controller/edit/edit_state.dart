part of 'edit_cubit.dart';

enum EditStatus {
  initial,
  loading,

  editRequestLoaded,

  error,
}

extension EditStateExtension on EditState {
  bool get isInitial => status == EditStatus.initial;
  bool get isLoading => status == EditStatus.loading;
  bool get isEditRequestLoaded => status == EditStatus.editRequestLoaded;

  bool get isError => status == EditStatus.error;
}

final class EditState extends Equatable {
  final EditStatus status;
  final String? errorMessage;
  final EditResponse? editResponse;

  const EditState({
    this.status = EditStatus.initial,
    this.errorMessage,
    this.editResponse,
  });

  EditState copyWith({
    EditStatus? status,
    String? errorMessage,
    EditResponse? editResponse,
  }) {
    return EditState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      editResponse: editResponse ?? this.editResponse,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, editResponse];
}
