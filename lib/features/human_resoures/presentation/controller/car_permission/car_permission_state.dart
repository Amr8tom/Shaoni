part of 'car_permission_cubit.dart';

/// Lifecycle of the Car Permission request flow.
enum CarPermissionStatus {
  initialized,

  /// Lookups
  brandsLoading,
  brandsLoaded,
  brandsError,
  colorsLoading,
  colorsLoaded,
  colorsError,

  /// Create request
  createRequestLoading,
  createRequestLoaded,
  createRequestError,

  /// Update request
  updateRequestLoading,
  updateRequestLoaded,
  updateRequestError,

  error,
}

/// Convenience getters used by the UI to decide which subtree to render.
extension CarPermissionStateExtension on CarPermissionState {
  bool get isInitialized => status == CarPermissionStatus.initialized;

  bool get isBrandsLoading => status == CarPermissionStatus.brandsLoading;
  bool get isBrandsLoaded => status == CarPermissionStatus.brandsLoaded;
  bool get isBrandsError => status == CarPermissionStatus.brandsError;

  bool get isColorsLoading => status == CarPermissionStatus.colorsLoading;
  bool get isColorsLoaded => status == CarPermissionStatus.colorsLoaded;
  bool get isColorsError => status == CarPermissionStatus.colorsError;

  bool get isCreateRequestLoading =>
      status == CarPermissionStatus.createRequestLoading;
  bool get isCreateRequestLoaded =>
      status == CarPermissionStatus.createRequestLoaded;
  bool get isCreateRequestError =>
      status == CarPermissionStatus.createRequestError;

  bool get isUpdateRequestLoading =>
      status == CarPermissionStatus.updateRequestLoading;
  bool get isUpdateRequestLoaded =>
      status == CarPermissionStatus.updateRequestLoaded;
  bool get isUpdateRequestError =>
      status == CarPermissionStatus.updateRequestError;

  /// True while any submit is in-flight (create or update).
  bool get isSubmitting =>
      isCreateRequestLoading || isUpdateRequestLoading;

  /// True when any submit succeeded.
  bool get isSubmitSucceeded =>
      isCreateRequestLoaded || isUpdateRequestLoaded;

  /// True when any submit failed.
  bool get isSubmitFailed =>
      isCreateRequestError || isUpdateRequestError;

  bool get isError => status == CarPermissionStatus.error;
}

final class CarPermissionState extends Equatable {
  final CarPermissionStatus status;
  final String? errorMessage;
  final String? successMessage;
  final String? requestNumber;

  const CarPermissionState({
    this.status = CarPermissionStatus.initialized,
    this.errorMessage,
    this.successMessage,
    this.requestNumber,
  });

  CarPermissionState copyWith({
    CarPermissionStatus? status,
    String? errorMessage,
    String? successMessage,
    String? requestNumber,
  }) {
    return CarPermissionState(
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
