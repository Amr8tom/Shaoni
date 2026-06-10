import '../../../domain/entity/salary_requests/create_salary_response.dart';

class CreateSalaryResponseModel extends CreateSalaryResponse {
  const CreateSalaryResponseModel({
    required super.code,
    required super.status,
    required super.message,
    super.salaryRequestLocalId,
    super.salaryRequestOdooId,
    super.salaryRequestName,
  });

  factory CreateSalaryResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateSalaryResponseModel(
      code: (json['code'] ?? '').toString(),
      status: json['status'] as String? ??
          (json['success'] == true ? 'success' : 'failed'),
      message: json['message'] as String? ?? '',
      salaryRequestLocalId: json['salaryRequestLocalId'] as int?,
      salaryRequestOdooId: json['salaryRequestOdooId'] as int?,
      salaryRequestName: json['salaryRequestName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(CreateSalaryResponse entity) {
    return {
      'code': entity.code,
      'status': entity.status,
      'message': entity.message,
      'salaryRequestLocalId': entity.salaryRequestLocalId,
      'salaryRequestOdooId': entity.salaryRequestOdooId,
      'salaryRequestName': entity.salaryRequestName,
    };
  }
}
