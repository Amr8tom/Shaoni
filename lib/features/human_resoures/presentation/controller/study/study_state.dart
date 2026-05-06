part of 'study_cubit.dart';

final class StudyState extends Equatable {
  final GeneralStatus status;
  final String? errorMessage;
  final String? requestNumber;

  const StudyState(
      {this.status = GeneralStatus.initialized,
      this.errorMessage,
      this.requestNumber});

  /// copy with
  StudyState copyWith({GeneralStatus? status}) {
    return StudyState(
        status: status ?? this.status,
        errorMessage: errorMessage,
        requestNumber: requestNumber);
  }

  @override
  List<Object?> get props => [status, errorMessage, requestNumber];
}

/// Lifecycle of the Study list screen.
enum StudyStatus {
  initialized,
  lookupsLoading,
  forgetError,
  lookupsError,
  lookupsLoaded,
  loading,
  createStudyRequestLoading,
  createStudyRequestLoaded,
  loaded,
  empty,
  error,
}

/// Convenience getters used by the UI to decide which subtree to render
/// (matches the project's existing `*StateExtension` style).
extension StudyStateExtension on StudyState {
  bool get isInitialized => status == StudyStatus.initialized;

  bool get isLoading => status == StudyStatus.loading;

  bool get isLookupsLoading => status == StudyStatus.lookupsLoading;

  bool get isCreateStudyRequestLoading =>
      status == StudyStatus.createStudyRequestLoading;

  bool get isCreateStudyRequestLoaded =>
      status == StudyStatus.createStudyRequestLoaded;

  bool get isSuccess => status == StudyStatus.loaded;

  bool get isLookupSuccess => status == StudyStatus.lookupsLoaded;

  bool get isEmpty => status == StudyStatus.empty;

  bool get isLookupError => status == StudyStatus.lookupsError;

  bool get isError => status == StudyStatus.error;
}
