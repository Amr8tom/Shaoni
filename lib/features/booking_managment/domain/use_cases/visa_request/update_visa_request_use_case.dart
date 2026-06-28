import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/create_visa_response.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/create_visa_request_use_case.dart';

class UpdateVisaRequestUseCase
    extends UseCase<CreateVisaResponse, UpdateVisaRequestParams> {
  final BookingManagementRepository _repository;

  UpdateVisaRequestUseCase(this._repository);

  @override
  Future<Either<Failure, CreateVisaResponse>> call({
    required UpdateVisaRequestParams params,
  }) async {
    return await _repository.updateVisaRequest(params: params);
  }
}

class UpdateVisaRequestParams extends Equatable {
  final int requestId;
  final CreateVisaRequestParams data;

  const UpdateVisaRequestParams({
    required this.requestId,
    required this.data,
  });

  @override
  List<Object?> get props => [requestId, data];
}
