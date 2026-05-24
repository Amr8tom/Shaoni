part of 'training_request_cubit.dart';

enum TrainingRequestStatus {
  initialized,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension TrainingRequestStatusX on TrainingRequestStatus {
  bool get isLoading =>
      this == TrainingRequestStatus.lookupsLoading ||
      this == TrainingRequestStatus.createLoading;
  bool get isError =>
      this == TrainingRequestStatus.lookupsError ||
      this == TrainingRequestStatus.createError;
  bool get isCreateLoaded => this == TrainingRequestStatus.createLoaded;
  bool get isLookupsLoaded => this == TrainingRequestStatus.lookupsLoaded;
}

class TrainingRequestState extends Equatable {
  final TrainingRequestStatus status;
  final String? errorMessage;
  final String? requestNumber;
  final Course? selectedCourse;

  const TrainingRequestState({
    this.status = TrainingRequestStatus.initialized,
    this.errorMessage,
    this.requestNumber,
    this.selectedCourse,
  });

  TrainingRequestState copyWith({
    TrainingRequestStatus? status,
    String? errorMessage,
    String? requestNumber,
    Course? selectedCourse,
    bool clearSelectedCourse = false,
  }) {
    return TrainingRequestState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
      selectedCourse: clearSelectedCourse ? null : (selectedCourse ?? this.selectedCourse),
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, requestNumber, selectedCourse];
}
