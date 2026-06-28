import 'package:equatable/equatable.dart';

class VisaRequestLineEntity extends Equatable {
  final int? id;
  final int? visaRequestLineOdooId;
  final int employeeId;
  final String dateFrom;
  final String dateTo;

  const VisaRequestLineEntity({
    this.id,
    this.visaRequestLineOdooId,
    required this.employeeId,
    this.dateFrom = '',
    this.dateTo = '',
  });

  @override
  List<Object?> get props =>
      [id, visaRequestLineOdooId, employeeId, dateFrom, dateTo];
}

class VisaRequestEntity extends Equatable {
  final int? id;
  final int? visaRequestOdooId;
  final String visaRequestOdooName;
  final String registrationNumber;
  final int? responsibleEmployeeId;
  final int? langId;
  final String visaTypeValue;
  final String direction;
  final String reason;
  final String note;
  final String? editReasons;
  final String? rejectReasons;
  final String date;
  final String dateFrom;
  final String dateTo;
  final String attachmentBase64;
  final List<VisaRequestLineEntity> lines;

  const VisaRequestEntity({
    this.id,
    this.visaRequestOdooId,
    this.visaRequestOdooName = '',
    this.registrationNumber = '',
    this.responsibleEmployeeId,
    this.langId,
    this.visaTypeValue = '',
    this.direction = '',
    this.reason = '',
    this.note = '',
    this.editReasons,
    this.rejectReasons,
    this.date = '',
    this.dateFrom = '',
    this.dateTo = '',
    this.attachmentBase64 = '',
    this.lines = const [],
  });

  @override
  List<Object?> get props => [
        id,
        visaRequestOdooId,
        visaRequestOdooName,
        registrationNumber,
        responsibleEmployeeId,
        langId,
        visaTypeValue,
        direction,
        reason,
        note,
        editReasons,
        rejectReasons,
        date,
        dateFrom,
        dateTo,
        attachmentBase64,
        lines,
      ];
}
