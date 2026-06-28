import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_employee.dart';

class VisaEmployeeModel extends VisaEmployee {
  const VisaEmployeeModel({
    required super.id,
    required super.name,
    super.jobTitle = '',
  });

  factory VisaEmployeeModel.fromJson(Map<String, dynamic> json) {
    return VisaEmployeeModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      jobTitle: json['job_title'] as String? ?? '',
    );
  }
}
