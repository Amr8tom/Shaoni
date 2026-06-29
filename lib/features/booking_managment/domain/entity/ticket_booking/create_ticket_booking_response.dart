import 'package:equatable/equatable.dart';

/// Domain entity for the response of
/// POST /EmployeeTicketBooking
class CreateTicketBookingResponse extends Equatable {
  final bool success;
  final String message;
  final int? requestId;
  final String requestName;

  const CreateTicketBookingResponse({
    this.success = false,
    this.message = '',
    this.requestId,
    this.requestName = '',
  });

  @override
  List<Object?> get props => [success, message, requestId, requestName];
}
