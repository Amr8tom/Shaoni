part of 'start_work_cubit.dart';

enum StartWorkStatus {
  initialized,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension StartWorkStateExtension on StartWorkState {
  bool get isInitialized => status == StartWorkStatus.initialized;
  bool get isLookupsLoading => status == StartWorkStatus.lookupsLoading;
  bool get isLookupsLoaded => status == StartWorkStatus.lookupsLoaded;
  bool get isLookupsError => status == StartWorkStatus.lookupsError;
  bool get isCreateLoading => status == StartWorkStatus.createLoading;
  bool get isCreateLoaded => status == StartWorkStatus.createLoaded;
  bool get isCreateError => status == StartWorkStatus.createError;
}

final class StartWorkState extends Equatable {
  final StartWorkStatus status;
  final String? errorMessage;
  final String? requestNumber;

  const StartWorkState({
    this.status = StartWorkStatus.initialized,
    this.errorMessage,
    this.requestNumber,
  });

  StartWorkState copyWith({
    StartWorkStatus? status,
    String? errorMessage,
    String? requestNumber,
  }) {
    return StartWorkState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, requestNumber];
}
