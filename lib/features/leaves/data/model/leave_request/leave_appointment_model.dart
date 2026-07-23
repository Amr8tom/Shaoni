import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_appointment.dart';

class LeaveAppointmentModel extends LeaveAppointment {
  const LeaveAppointmentModel({
    super.id,
    super.name = '',
    super.requestDateFrom = '',
    super.requestDateTo = '',
    super.holidayStatusName = '',
    super.stageName = '',
  });

  factory LeaveAppointmentModel.fromJson(Map<String, dynamic> json) {
    String nestedName(Object? value) {
      if (value is Map) return value['name'] as String? ?? '';
      return '';
    }

    return LeaveAppointmentModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      requestDateFrom: json['requestDateFrom'] as String? ?? '',
      requestDateTo: json['requestDateTo'] as String? ?? '',
      holidayStatusName: nestedName(json['holidayStatusId']),
      stageName: nestedName(json['stageId']),
    );
  }
}
