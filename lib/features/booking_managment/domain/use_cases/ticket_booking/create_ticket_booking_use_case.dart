import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/ticket_booking/create_ticket_booking_response.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';

class CreateTicketBookingUseCase
    extends UseCase<CreateTicketBookingResponse, CreateTicketBookingParams> {
  final BookingManagementRepository _repository;

  CreateTicketBookingUseCase(this._repository);

  @override
  Future<Either<Failure, CreateTicketBookingResponse>> call({
    required CreateTicketBookingParams params,
  }) async {
    return await _repository.createTicketBooking(params: params);
  }
}

class TicketBookingLineParams extends Equatable {
  final int employeeId;
  final String travelDate;
  final int ticketType;
  final String attachment;

  const TicketBookingLineParams({
    required this.employeeId,
    required this.travelDate,
    required this.ticketType,
    this.attachment = '',
  });

  Map<String, dynamic> toMap() => {
        'employee_id': employeeId,
        'travel_date': travelDate,
        'ticket_type': ticketType,
        'attachment': attachment,
      };

  @override
  List<Object?> get props => [employeeId, travelDate, ticketType, attachment];
}

class TicketBookingAttachmentParams extends Equatable {
  final String name;
  final String attachment;

  const TicketBookingAttachmentParams({
    this.name = '',
    this.attachment = '',
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'attachment': attachment,
      };

  @override
  List<Object?> get props => [name, attachment];
}

class CreateTicketBookingParams extends Equatable {
  final int responsibleEmployee;
  final int officeId;
  final String date;
  final String travelDate;
  final String ticketType;
  final String taskType;
  final String direction;
  final String note;
  final List<TicketBookingLineParams> lineIds;
  final List<TicketBookingAttachmentParams> attachmentIds;

  const CreateTicketBookingParams({
    required this.responsibleEmployee,
    required this.officeId,
    required this.date,
    required this.travelDate,
    required this.ticketType,
    required this.taskType,
    required this.direction,
    this.note = '',
    required this.lineIds,
    this.attachmentIds = const [],
  });

  Map<String, dynamic> toMap() => {
        'responsible_employee': responsibleEmployee,
        'office_id': officeId,
        'date': date,
        'travel_date': travelDate,
        'ticket_type': ticketType,
        'task_type': taskType,
        'direction': direction,
        'note': note,
        'line_ids': lineIds.map((line) => line.toMap()).toList(),
        'attachment_ids':
            attachmentIds.map((attachment) => attachment.toMap()).toList(),
      };

  @override
  List<Object?> get props => [
        responsibleEmployee,
        officeId,
        date,
        travelDate,
        ticketType,
        taskType,
        direction,
        note,
        lineIds,
        attachmentIds,
      ];
}
