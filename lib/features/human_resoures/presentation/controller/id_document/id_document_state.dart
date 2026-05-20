part of 'id_document_cubit.dart';

enum IDDocumentStatus {
  initial,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension IDDocumentStatusX on IDDocumentStatus {
  bool get isLoading =>
      this == IDDocumentStatus.lookupsLoading ||
      this == IDDocumentStatus.createLoading;

  bool get isError =>
      this == IDDocumentStatus.lookupsError ||
      this == IDDocumentStatus.createError;

  bool get isCreateLoaded => this == IDDocumentStatus.createLoaded;
}

class IDDocumentState extends Equatable {
  final IDDocumentStatus status;
  final String? errorMessage;
  final String? requestNumber;

  const IDDocumentState({
    this.status = IDDocumentStatus.initial,
    this.errorMessage,
    this.requestNumber,
  });

  IDDocumentState copyWith({
    IDDocumentStatus? status,
    String? errorMessage,
    String? requestNumber,
  }) {
    return IDDocumentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, requestNumber];
}
