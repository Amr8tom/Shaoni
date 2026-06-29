import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/ticket_booking/create_ticket_booking_response.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/ticket_booking/create_ticket_booking_use_case.dart';

class UpdateTicketBookingUseCase
    extends UseCase<CreateTicketBookingResponse, UpdateTicketBookingParams> {
  final BookingManagementRepository _repository;

  UpdateTicketBookingUseCase(this._repository);

  @override
  Future<Either<Failure, CreateTicketBookingResponse>> call({
    required UpdateTicketBookingParams params,
  }) async {
    return await _repository.updateTicketBooking(params: params);
  }
}

class UpdateTicketBookingParams extends Equatable {
  final int requestId;
  final CreateTicketBookingParams data;

  const UpdateTicketBookingParams({
    required this.requestId,
    required this.data,
  });

  @override
  List<Object?> get props => [requestId, data];
}
