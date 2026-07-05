import 'package:shaoni/features/leaves/domain/entity/leave_interruption/leave_type.dart';

class LeaveTypeModel extends LeaveType {
  const LeaveTypeModel({
    required super.id,
    super.nameAr = '',
    super.nameEn = '',
  });

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
      id: json['id'] as int? ?? 0,
      nameAr: json['nameAr'] as String? ?? '',
      nameEn: json['nameEn'] as String? ?? '',
    );
  }
}
