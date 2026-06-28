import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_type.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';

class GetVisaTypesUseCase extends UseCase<List<VisaType>, NoParams> {
  final BookingManagementRepository _repository;

  GetVisaTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<VisaType>>> call({
    required NoParams params,
  }) async {
    return await _repository.getVisaTypes(params: params);
  }
}
