import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/leave_request.dart';

class LeaveRequestAttachmentModel extends LeaveRequestAttachment {
  const LeaveRequestAttachmentModel(
      {super.id, super.name = '', super.url = ''});

  factory LeaveRequestAttachmentModel.fromJson(Map<String, dynamic> json) {
    return LeaveRequestAttachmentModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }

  static Map<String, dynamic> toJsonFromEntity(LeaveRequestAttachment e) => {
        'id': e.id,
        'name': e.name,
        'url': e.url,
      };
}

class LeaveRequestModel extends LeaveRequestEntity {
  const LeaveRequestModel({
    super.name = '',
    super.holidayType = '',
    super.employeeId,
    super.employeeName = '',
    super.alternativeEmployeeId,
    super.alternativeEmployeeName = '',
    super.departmentId,
    super.departmentName = '',
    super.holidayStatusId,
    super.holidayStatusName = '',
    super.resourceCalendarName = '',
    super.stateAr = '',
    super.stateEn = '',
    super.validationTypeAr = '',
    super.validationTypeEn = '',
    super.requestDateFrom = '',
    super.requestDateTo = '',
    super.requestUnitHours = false,
    super.requestUnitHalf = false,
    super.stageName = '',
    super.editReasons,
    super.rejectReasons,
    super.attachments = const [],
  });

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    String label(Object? value, String key) {
      if (value is Map) return value[key] as String? ?? '';
      return '';
    }

    final rawAttachments = json['supportedAttachments'];

    return LeaveRequestModel(
      name: json['name'] as String? ?? '',
      holidayType: json['holidayType'] as String? ?? '',
      employeeId: json['employeeId'] as int?,
      employeeName: json['employeeName'] as String? ?? '',
      alternativeEmployeeId: json['alternativeEmployeeId'] as int?,
      alternativeEmployeeName: json['alternativeEmployeeName'] as String? ?? '',
      departmentId: json['departmentId'] as int?,
      departmentName: json['departmentName'] as String? ?? '',
      holidayStatusId: json['holidayStatusId'] as int?,
      holidayStatusName: json['holidayStatusName'] as String? ?? '',
      resourceCalendarName: json['resourceCalendarName'] as String? ?? '',
      stateAr: label(json['stateLabels'], 'ar_001'),
      stateEn: label(json['stateLabels'], 'en_US'),
      validationTypeAr: label(json['validationTypeLabels'], 'ar_001'),
      validationTypeEn: label(json['validationTypeLabels'], 'en_US'),
      requestDateFrom: json['requestDateFrom'] as String? ?? '',
      requestDateTo: json['requestDateTo'] as String? ?? '',
      requestUnitHours: json['requestUnitHours'] as bool? ?? false,
      requestUnitHalf: json['requestUnitHalf'] as bool? ?? false,
      stageName: json['stageName'] as String? ?? '',
      editReasons: json['editReasons'] as String?,
      rejectReasons: json['rejectReasons'] as String?,
      attachments: rawAttachments is List
          ? rawAttachments
              .whereType<Map<String, dynamic>>()
              .map(LeaveRequestAttachmentModel.fromJson)
              .toList()
          : const [],
    );
  }

  static Map<String, dynamic> toJsonFromEntity(LeaveRequestEntity e) {
    return {
      'name': e.name,
      'holidayType': e.holidayType,
      'employeeId': e.employeeId,
      'employeeName': e.employeeName,
      'alternativeEmployeeId': e.alternativeEmployeeId,
      'alternativeEmployeeName': e.alternativeEmployeeName,
      'departmentId': e.departmentId,
      'departmentName': e.departmentName,
      'holidayStatusId': e.holidayStatusId,
      'holidayStatusName': e.holidayStatusName,
      'resourceCalendarName': e.resourceCalendarName,
      'stateLabels': {'ar_001': e.stateAr, 'en_US': e.stateEn},
      'validationTypeLabels': {
        'ar_001': e.validationTypeAr,
        'en_US': e.validationTypeEn,
      },
      'requestDateFrom': e.requestDateFrom,
      'requestDateTo': e.requestDateTo,
      'requestUnitHours': e.requestUnitHours,
      'requestUnitHalf': e.requestUnitHalf,
      'stageName': e.stageName,
      'editReasons': e.editReasons,
      'rejectReasons': e.rejectReasons,
      'supportedAttachments': e.attachments
          .map(LeaveRequestAttachmentModel.toJsonFromEntity)
          .toList(),
    };
  }
}
