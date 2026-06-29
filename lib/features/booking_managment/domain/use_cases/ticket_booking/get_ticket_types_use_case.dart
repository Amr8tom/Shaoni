import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/ticket_booking/ticket_class.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';

class GetTicketTypesUseCase extends UseCase<List<TicketClass>, NoParams> {
  final BookingManagementRepository _repository;

  GetTicketTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<TicketClass>>> call({
    required NoParams params,
  }) async {
    return await _repository.getTicketTypes(params: params);
  }
}
