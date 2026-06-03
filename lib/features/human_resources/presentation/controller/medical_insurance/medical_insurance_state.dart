part of 'medical_insurance_cubit.dart';

enum MedicalInsuranceStatus {
  initialized,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension MedicalInsuranceStatusX on MedicalInsuranceStatus {
  bool get isLoading =>
      this == MedicalInsuranceStatus.lookupsLoading ||
      this == MedicalInsuranceStatus.createLoading;
  bool get isError =>
      this == MedicalInsuranceStatus.lookupsError ||
      this == MedicalInsuranceStatus.createError;
  bool get isCreateLoaded => this == MedicalInsuranceStatus.createLoaded;
  bool get isLookupsError => this == MedicalInsuranceStatus.lookupsError;
}

class MedicalInsuranceState extends Equatable {
  final MedicalInsuranceStatus status;
  final String? errorMessage;
  final String? requestNumber;
  final bool includeFamilyMember;
  final Set<int> selectedRelativeIds;

  const MedicalInsuranceState({
    this.status = MedicalInsuranceStatus.initialized,
    this.errorMessage,
    this.requestNumber,
    this.includeFamilyMember = false,
    this.selectedRelativeIds = const {},
  });

  MedicalInsuranceState copyWith({
    MedicalInsuranceStatus? status,
    String? errorMessage,
    String? requestNumber,
    bool? includeFamilyMember,
    Set<int>? selectedRelativeIds,
  }) {
    return MedicalInsuranceState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
      includeFamilyMember: includeFamilyMember ?? this.includeFamilyMember,
      selectedRelativeIds: selectedRelativeIds ?? this.selectedRelativeIds,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        requestNumber,
        includeFamilyMember,
        selectedRelativeIds,
      ];
}
