import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_employee.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';

class GetVisaEmployeesUseCase
    extends UseCase<List<VisaEmployee>, GetVisaEmployeesParams> {
  final BookingManagementRepository _repository;

  GetVisaEmployeesUseCase(this._repository);

  @override
  Future<Either<Failure, List<VisaEmployee>>> call({
    required GetVisaEmployeesParams params,
  }) async {
    return await _repository.getVisaEmployees(params: params);
  }
}

class GetVisaEmployeesParams extends Equatable {
  final bool isSaudi;

  const GetVisaEmployeesParams({required this.isSaudi});

  @override
  List<Object?> get props => [isSaudi];
}
