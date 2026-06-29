import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_employee.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';

class GetTicketEmployeesUseCase extends UseCase<List<VisaEmployee>, NoParams> {
  final BookingManagementRepository _repository;

  GetTicketEmployeesUseCase(this._repository);

  @override
  Future<Either<Failure, List<VisaEmployee>>> call({
    required NoParams params,
  }) async {
    return await _repository.getTicketEmployees(params: params);
  }
}
