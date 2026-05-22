import 'package:equatable/equatable.dart';

class MedicalInsuranceDetails extends Equatable {
  final String? externalName;
  final String? date;
  final String? insuranceClassName;
  final bool? includeFamilyMember;
  final String? reasonForUpgrade;
  final String? note;
  final String? state;
  final String? editReasons;
  final String? rejectReasons;

  const MedicalInsuranceDetails({
    this.externalName,
    this.date,
    this.insuranceClassName,
    this.includeFamilyMember,
    this.reasonForUpgrade,
    this.note,
    this.state,
    this.editReasons,
    this.rejectReasons,
  });

  @override
  List<Object?> get props => [
        externalName,
        date,
        insuranceClassName,
        includeFamilyMember,
        reasonForUpgrade,
        note,
        state,
        editReasons,
        rejectReasons,
      ];
}
