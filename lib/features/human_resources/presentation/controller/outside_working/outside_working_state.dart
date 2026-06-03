part of 'outside_working_cubit.dart';

enum OutsideWorkingStatus {
  initial,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension OutsideWorkingStatusX on OutsideWorkingStatus {
  bool get isLookupsLoading => this == OutsideWorkingStatus.lookupsLoading;

  bool get isCreateLoading => this == OutsideWorkingStatus.createLoading;

  bool get isLoading =>
      this == OutsideWorkingStatus.lookupsLoading ||
      this == OutsideWorkingStatus.createLoading;

  bool get isError =>
      this == OutsideWorkingStatus.lookupsError ||
      this == OutsideWorkingStatus.createError;

  bool get isCreateLoaded => this == OutsideWorkingStatus.createLoaded;
}

class OutsideWorkingState extends Equatable {
  final OutsideWorkingStatus status;
  final String? errorMessage;
  final String? requestNumber;

  /// Incremented on every notifyDropdownChanged() so Equatable sees a new state.
  final int version;

  const OutsideWorkingState({
    this.status = OutsideWorkingStatus.initial,
    this.errorMessage,
    this.requestNumber,
    this.version = 0,
  });

  OutsideWorkingState copyWith({
    OutsideWorkingStatus? status,
    String? errorMessage,
    String? requestNumber,
    int? version,
  }) {
    return OutsideWorkingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
      version: version ?? this.version,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, requestNumber, version];
}
