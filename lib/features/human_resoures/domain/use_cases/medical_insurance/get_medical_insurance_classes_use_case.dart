import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/medical_insurance/medical_insurance_class.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class GetMedicalInsuranceClassesUseCase
    extends UseCase<List<MedicalInsuranceClass>, NoParams> {
  final HRServicesRepository _repository;

  GetMedicalInsuranceClassesUseCase(this._repository);

  @override
  Future<Either<Failure, List<MedicalInsuranceClass>>> call({
    required NoParams params,
  }) async {
    return await _repository.getMedicalInsuranceClasses(params: params);
  }
}
