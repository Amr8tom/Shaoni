part of 'experience_certificate_cubit.dart';

enum ExperienceCertificateStatus {
  initialized,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension ExperienceCertificateStatusX on ExperienceCertificateStatus {
  bool get isLoading =>
      this == ExperienceCertificateStatus.lookupsLoading ||
      this == ExperienceCertificateStatus.createLoading;
  bool get isError =>
      this == ExperienceCertificateStatus.lookupsError ||
      this == ExperienceCertificateStatus.createError;
  bool get isCreateLoaded =>
      this == ExperienceCertificateStatus.createLoaded;
  bool get isLookupsError =>
      this == ExperienceCertificateStatus.lookupsError;
}

class ExperienceCertificateState extends Equatable {
  final ExperienceCertificateStatus status;
  final String? errorMessage;
  final String? requestNumber;

  const ExperienceCertificateState({
    this.status = ExperienceCertificateStatus.initialized,
    this.errorMessage,
    this.requestNumber,
  });

  ExperienceCertificateState copyWith({
    ExperienceCertificateStatus? status,
    String? errorMessage,
    String? requestNumber,
  }) {
    return ExperienceCertificateState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, requestNumber];
}
