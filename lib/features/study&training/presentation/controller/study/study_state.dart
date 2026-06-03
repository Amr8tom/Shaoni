part of 'study_cubit.dart';

enum StudyStatus {
  initialized,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createStudyRequestLoading,
  createStudyRequestLoaded,
  createStudyRequestError,
  error,
}

extension StudyStateExtension on StudyState {
  bool get isInitialized => status == StudyStatus.initialized;
  bool get isLookupsLoading => status == StudyStatus.lookupsLoading;
  bool get isLookupsLoaded => status == StudyStatus.lookupsLoaded;
  bool get isLookupsError => status == StudyStatus.lookupsError;
  bool get isCreateStudyRequestLoading =>
      status == StudyStatus.createStudyRequestLoading;
  bool get isCreateStudyRequestLoaded =>
      status == StudyStatus.createStudyRequestLoaded;
  bool get isCreateStudyRequestError =>
      status == StudyStatus.createStudyRequestError;
  bool get isError => status == StudyStatus.error;
}

final class StudyState extends Equatable {
  final StudyStatus status;
  final String? errorMessage;
  final String? requestNumber;

  const StudyState({
    this.status = StudyStatus.initialized,
    this.errorMessage,
    this.requestNumber,
  });

  StudyState copyWith({
    StudyStatus? status,
    String? errorMessage,
    String? requestNumber,
  }) {
    return StudyState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, requestNumber];
}
