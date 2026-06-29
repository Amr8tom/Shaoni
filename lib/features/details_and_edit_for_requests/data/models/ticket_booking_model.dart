import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/ticket_booking.dart';

class TicketBookingLineModel extends TicketBookingLineEntity {
  const TicketBookingLineModel({
    required super.employeeId,
    super.employeeName = '',
    super.travelDate = '',
    super.ticketType,
    super.ticketTypeName = '',
    super.attachment = '',
  });

  factory TicketBookingLineModel.fromJson(Map<String, dynamic> json) {
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

    return TicketBookingLineModel(
      employeeId: parseId(json['employeeId']) ?? 0,
      employeeName: parseName(json['employeeId']),
      travelDate: json['travelDate'] as String? ?? '',
      ticketType: parseId(json['ticketType']),
      ticketTypeName: parseName(json['ticketType']),
      attachment: json['attachment'] as String? ?? '',
    );
  }
}

class TicketBookingModel extends TicketBookingEntity {
  const TicketBookingModel({
    super.externalName = '',
    super.state = '',
    super.date = '',
    super.travelDate = '',
    super.ticketType = '',
    super.taskType = '',
    super.direction = '',
    super.note = '',
    super.editReasons,
    super.rejectReasons,
    super.responsibleEmployee,
    super.officeId,
    super.lines = const [],
  });

  factory TicketBookingModel.fromJson(Map<String, dynamic> json) {
    final rawLines = json['lines'];
    final List<TicketBookingLineModel> lineItems = rawLines is List
        ? rawLines
            .map((e) =>
                TicketBookingLineModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : [];

    return TicketBookingModel(
      externalName: json['externalName'] as String? ?? '',
      state: json['state'] as String? ?? '',
      date: json['date'] as String? ?? '',
      travelDate: json['travelDate'] as String? ?? '',
      ticketType: json['ticketType'] as String? ?? '',
      taskType: json['taskType'] as String? ?? '',
      direction: json['direction'] as String? ?? '',
      note: json['note'] as String? ?? '',
      editReasons: json['editReasons'] as String?,
      rejectReasons: json['rejectReasons'] as String?,
      responsibleEmployee: json['responsibleEmployee'] as int?,
      officeId: json['officeId'] as int?,
      lines: lineItems,
    );
  }

  static Map<String, dynamic> toJsonFromEntity(TicketBookingEntity entity) {
    return {
      'externalName': entity.externalName,
      'state': entity.state,
      'date': entity.date,
      'travelDate': entity.travelDate,
      'ticketType': entity.ticketType,
      'taskType': entity.taskType,
      'direction': entity.direction,
      'note': entity.note,
      'editReasons': entity.editReasons,
      'rejectReasons': entity.rejectReasons,
      'responsibleEmployee': entity.responsibleEmployee,
      'officeId': entity.officeId,
      'lines': entity.lines
          .map((l) => {
                'employeeId': l.employeeId,
                'travelDate': l.travelDate,
                'ticketType': l.ticketType,
                'attachment': l.attachment,
              })
          .toList(),
    };
  }
}
