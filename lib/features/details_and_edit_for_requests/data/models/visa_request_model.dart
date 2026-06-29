import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/visa_request.dart';

class VisaRequestLineModel extends VisaRequestLineEntity {
  const VisaRequestLineModel({
    super.id,
    super.visaRequestLineOdooId,
    required super.employeeId,
    super.employeeName = '',
    super.dateFrom = '',
    super.dateTo = '',
  });

  factory VisaRequestLineModel.fromJson(Map<String, dynamic> json) {
    int? parseId(dynamic val) {
      if (val is List && val.isNotEmpty) return val[0] as int;
      if (val is int) return val;
      return null;
    }

    String parseName(dynamic val) {
      if (val is List && val.length > 1) return val[1].toString();
      if (val is String) return val;
      return '';
    }

    return VisaRequestLineModel(
      id: json['id'] as int?,
      visaRequestLineOdooId: json['visaRequestLineOdooId'] as int?,
      employeeId: parseId(json['employeeId']) ?? 0,
      employeeName: parseName(json['employeeId']),
      dateFrom: json['dateFrom'] as String? ?? '',
      dateTo: json['dateTo'] as String? ?? '',
    );
  }
}

class VisaRequestModel extends VisaRequestEntity {
  const VisaRequestModel({
    super.id,
    super.visaRequestOdooId,
    super.visaRequestOdooName = '',
    super.registrationNumber = '',
    super.responsibleEmployeeId,
    super.langId,
    super.visaTypeValue = '',
    super.direction = '',
    super.reason = '',
    super.note = '',
    super.editReasons,
    super.rejectReasons,
    super.date = '',
    super.dateFrom = '',
    super.dateTo = '',
    super.attachmentBase64 = '',
    super.lines = const [],
  });

  factory VisaRequestModel.fromJson(Map<String, dynamic> json) {
    final rawLines = json['lines'];
    final List<VisaRequestLineModel> lineItems = rawLines is List
        ? rawLines
            .map(
                (e) => VisaRequestLineModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : [];

    return VisaRequestModel(
      id: json['id'] as int?,
      visaRequestOdooId: json['visaRequestOdooId'] as int?,
      visaRequestOdooName: json['visaRequestOdooName'] as String? ?? '',
      registrationNumber: json['registrationNumber'] as String? ?? '',
      responsibleEmployeeId: json['responsibleEmployeeId'] as int?,
      langId: json['langId'] as int?,
      visaTypeValue: json['visaTypeValue'] as String? ?? '',
      direction: json['direction'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
      note: json['note'] as String? ?? '',
      editReasons: json['editReasons'] as String?,
      rejectReasons: json['rejectReasons'] as String?,
      date: json['date'] as String? ?? '',
      dateFrom: json['dateFrom'] as String? ?? '',
      dateTo: json['dateTo'] as String? ?? '',
      attachmentBase64: json['attachmentBase64'] as String? ?? '',
      lines: lineItems,
    );
  }

  static Map<String, dynamic> toJsonFromEntity(VisaRequestEntity entity) {
    return {
      'id': entity.id,
      'visaRequestOdooId': entity.visaRequestOdooId,
      'visaRequestOdooName': entity.visaRequestOdooName,
      'registrationNumber': entity.registrationNumber,
      'responsibleEmployeeId': entity.responsibleEmployeeId,
      'langId': entity.langId,
      'visaTypeValue': entity.visaTypeValue,
      'direction': entity.direction,
      'reason': entity.reason,
      'note': entity.note,
      'editReasons': entity.editReasons,
      'rejectReasons': entity.rejectReasons,
      'date': entity.date,
      'dateFrom': entity.dateFrom,
      'dateTo': entity.dateTo,
      'attachmentBase64': entity.attachmentBase64,
      'lines': entity.lines
          .map((l) => {
                'id': l.id,
                'visaRequestLineOdooId': l.visaRequestLineOdooId,
                'employeeId': l.employeeId,
                'dateFrom': l.dateFrom,
                'dateTo': l.dateTo,
              })
          .toList(),
    };
  }
}
