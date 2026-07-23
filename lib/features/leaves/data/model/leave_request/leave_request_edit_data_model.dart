import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_request_edit_data.dart';

class LeaveRequestEditDataModel extends LeaveRequestEditData {
  const LeaveRequestEditDataModel({
    super.holidayType = 'employee',
    super.holidayStatusId,
    super.alternativeEmployeeId,
    super.validationType = '',
    super.requestDateFrom = '',
    super.requestDateTo = '',
    super.requestUnitHours = false,
    super.requestUnitHalf = false,
    super.sequenceNumber = '',
    super.attachments = const [],
  });

  /// Parses the `extraData.leaveRequest` object.
  factory LeaveRequestEditDataModel.fromJson(Map<String, dynamic> json) {
    final rawAttachments = json['supportedAttachments'];
    return LeaveRequestEditDataModel(
      holidayType: json['holidayType'] as String? ?? 'employee',
      holidayStatusId: json['holidayStatusId'] as int?,
      alternativeEmployeeId: json['alternativeEmployeeId'] as int?,
      validationType: json['validationTypeValue'] as String? ?? '',
      requestDateFrom: json['requestDateFrom'] as String? ?? '',
      requestDateTo: json['requestDateTo'] as String? ?? '',
      requestUnitHours: json['requestUnitHours'] as bool? ?? false,
      requestUnitHalf: json['requestUnitHalf'] as bool? ?? false,
      sequenceNumber: json['name'] as String? ?? '',
      attachments: rawAttachments is List
          ? rawAttachments.whereType<Map<String, dynamic>>().map((a) {
              return LeaveRequestEditAttachment(
                id: a['id'] as int?,
                name: a['name'] as String? ?? '',
                url: a['url'] as String? ?? '',
              );
            }).toList()
          : const [],
    );
  }
}
