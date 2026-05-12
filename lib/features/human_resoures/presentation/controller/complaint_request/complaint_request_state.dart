part of 'complaint_request_cubit.dart';

/// Lifecycle of the Complaint Request flow.
enum ComplaintRequestStatus {
  initialized,

  /// Lookups
  typesLoading,
  typesLoaded,
  typesError,
  reasonsLoading,
  reasonsLoaded,
  reasonsError,

  /// Create request
  createRequestLoading,
  createRequestLoaded,
  createRequestError,

  error,
}

/// Convenience getters used by the UI — same pattern as other HR services.
extension ComplaintRequestStateExtension on ComplaintRequestState {
  bool get isInitialized => status == ComplaintRequestStatus.initialized;

  bool get isTypesLoading => status == ComplaintRequestStatus.typesLoading;
  bool get isTypesLoaded => status == ComplaintRequestStatus.typesLoaded;
  bool get isTypesError => status == ComplaintRequestStatus.typesError;

  bool get isReasonsLoading => status == ComplaintRequestStatus.reasonsLoading;
  bool get isReasonsLoaded => status == ComplaintRequestStatus.reasonsLoaded;
  bool get isReasonsError => status == ComplaintRequestStatus.reasonsError;

  bool get isCreateRequestLoading =>
      status == ComplaintRequestStatus.createRequestLoading;
  bool get isCreateRequestLoaded =>
      status == ComplaintRequestStatus.createRequestLoaded;
  bool get isCreateRequestError =>
      status == ComplaintRequestStatus.createRequestError;

  bool get isError => status == ComplaintRequestStatus.error;
}

final class ComplaintRequestState extends Equatable {
  final ComplaintRequestStatus status;
  final String? errorMessage;
  final String? successMessage;
  final String? requestNumber;

  const ComplaintRequestState({
    this.status = ComplaintRequestStatus.initialized,
    this.errorMessage,
    this.successMessage,
    this.requestNumber,
  });

  ComplaintRequestState copyWith({
    ComplaintRequestStatus? status,
    String? errorMessage,
    String? successMessage,
    String? requestNumber,
  }) {
    return ComplaintRequestState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, successMessage, requestNumber];
}
