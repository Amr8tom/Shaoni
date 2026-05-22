import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/medical_insurance/create_medical_insurance_response.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/medical_insurance/create_medical_insurance_use_case.dart';

class UpdateMedicalInsuranceUseCase extends UseCase<
    CreateMedicalInsuranceResponse, UpdateMedicalInsuranceParams> {
  final HRServicesRepository _repository;

  UpdateMedicalInsuranceUseCase(this._repository);

  @override
  Future<Either<Failure, CreateMedicalInsuranceResponse>> call({
    required UpdateMedicalInsuranceParams params,
  }) async {
    return await _repository.updateMedicalInsurance(params: params);
  }
}

class UpdateMedicalInsuranceParams extends Equatable {
  final int requestId;
  final CreateMedicalInsuranceParams data;

  const UpdateMedicalInsuranceParams({
    required this.requestId,
    required this.data,
  });

  Map<String, dynamic> toMap() => data.toMap();

  @override
  List<Object?> get props => [requestId, data];
}
