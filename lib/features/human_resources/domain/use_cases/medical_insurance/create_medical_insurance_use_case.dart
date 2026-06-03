import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/medical_insurance/create_medical_insurance_response.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class CreateMedicalInsuranceUseCase extends UseCase<
    CreateMedicalInsuranceResponse, CreateMedicalInsuranceParams> {
  final HRServicesRepository _repository;

  CreateMedicalInsuranceUseCase(this._repository);

  @override
  Future<Either<Failure, CreateMedicalInsuranceResponse>> call({
    required CreateMedicalInsuranceParams params,
  }) async {
    return await _repository.createMedicalInsurance(params: params);
  }
}

class CreateMedicalInsuranceParams extends Equatable {
  final int employeeId;
  final int officeId;
  final int newInsuranceClass;
  final bool includeFamilyMember;
  final List<int> applicantDependantsIds;
  final String reasonForUpgrade;
  final String note;
  final String date;
  final List<Map<String, dynamic>> attachmentIds;

  const CreateMedicalInsuranceParams({
    required this.employeeId,
    required this.officeId,
    required this.newInsuranceClass,
    required this.includeFamilyMember,
    this.applicantDependantsIds = const [],
    required this.reasonForUpgrade,
    this.note = '',
    required this.date,
    this.attachmentIds = const [],
  });

  Map<String, dynamic> toMap() => {
        'employee_id': employeeId,
        'office_id': officeId,
        'new_insurance_class': newInsuranceClass,
        'include_family_member': includeFamilyMember,
        'applicant_dependants_ids': applicantDependantsIds,
        'reason_for_upgrade': reasonForUpgrade,
        'note': note,
        'date': date,
        'attachment_ids': attachmentIds,
      };

  @override
  List<Object?> get props => [
        employeeId,
        officeId,
        newInsuranceClass,
        includeFamilyMember,
        applicantDependantsIds,
        reasonForUpgrade,
        note,
        date,
        attachmentIds,
      ];
}
