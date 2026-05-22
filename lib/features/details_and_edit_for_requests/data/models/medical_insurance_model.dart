import '../../../details_and_edit_for_requests/domain/entities/medical_insurance/medical_insurance_details.dart';

class MedicalInsuranceModel extends MedicalInsuranceDetails {
  const MedicalInsuranceModel({
    super.externalName,
    super.date,
    super.insuranceClassName,
    super.includeFamilyMember,
    super.reasonForUpgrade,
    super.note,
    super.state,
    super.editReasons,
    super.rejectReasons,
  });

  factory MedicalInsuranceModel.fromJson(Map<String, dynamic> json) {
    return MedicalInsuranceModel(
      externalName: json['externalName'] ?? '',
      date: json['date'] ?? '',
      insuranceClassName: json['insuranceClassName'] ??
          json['newInsuranceClassName'] ??
          '',
      includeFamilyMember: json['includeFamilyMember'] ?? false,
      reasonForUpgrade: json['reasonForUpgrade'] ?? '',
      note: json['note'] ?? '',
      state: json['state'] ?? '',
      editReasons: json['editReasons'],
      rejectReasons: json['rejectReasons'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'externalName': externalName,
      'date': date,
      'insuranceClassName': insuranceClassName,
      'includeFamilyMember': includeFamilyMember,
      'reasonForUpgrade': reasonForUpgrade,
      'note': note,
      'state': state,
      'editReasons': editReasons,
      'rejectReasons': rejectReasons,
    };
  }
}
