import 'package:equatable/equatable.dart';

class CreateSalaryResponse extends Equatable {
  final String code;
  final String status;
  final String message;
  final int? salaryRequestLocalId;
  final int? salaryRequestOdooId;
  final String? salaryRequestName;

  const CreateSalaryResponse({
    required this.code,
    required this.status,
    required this.message,
    this.salaryRequestLocalId,
    this.salaryRequestOdooId,
    this.salaryRequestName,
  });

  @override
  List<Object?> get props => [
        code,
        status,
        message,
        salaryRequestLocalId,
        salaryRequestOdooId,
        salaryRequestName,
      ];
}
