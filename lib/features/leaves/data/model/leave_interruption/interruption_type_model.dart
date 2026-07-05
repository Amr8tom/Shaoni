import 'package:shaoni/features/leaves/domain/entity/leave_interruption/interruption_type.dart';

class InterruptionTypeModel extends InterruptionType {
  const InterruptionTypeModel({required super.id, required super.name});

  factory InterruptionTypeModel.fromJson(Map<String, dynamic> json) {
    return InterruptionTypeModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
