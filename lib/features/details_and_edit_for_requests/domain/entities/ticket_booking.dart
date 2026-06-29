import 'package:equatable/equatable.dart';

class TicketBookingLineEntity extends Equatable {
  final int employeeId;
  final String employeeName;
  final String travelDate;
  final int? ticketType;
  final String ticketTypeName;
  final String attachment;

  const TicketBookingLineEntity({
    required this.employeeId,
    this.employeeName = '',
    this.travelDate = '',
    this.ticketType,
    this.ticketTypeName = '',
    this.attachment = '',
  });

  @override
  List<Object?> get props => [
        employeeId,
        employeeName,
        travelDate,
        ticketType,
        ticketTypeName,
        attachment,
      ];
}

class TicketBookingEntity extends Equatable {
  final String externalName;
  final String state;
  final String date;
  final String travelDate;
  final String ticketType;
  final String taskType;
  final String direction;
  final String note;
  final String? editReasons;
  final String? rejectReasons;
  final int? responsibleEmployee;
  final int? officeId;
  final List<TicketBookingLineEntity> lines;

  const TicketBookingEntity({
    this.externalName = '',
    this.state = '',
    this.date = '',
    this.travelDate = '',
    this.ticketType = '',
    this.taskType = '',
    this.direction = '',
    this.note = '',
    this.editReasons,
    this.rejectReasons,
    this.responsibleEmployee,
    this.officeId,
    this.lines = const [],
  });

  @override
  List<Object?> get props => [
        externalName,
        state,
        date,
        travelDate,
        ticketType,
        taskType,
        direction,
        note,
        editReasons,
        rejectReasons,
        responsibleEmployee,
        officeId,
        lines,
      ];
}
