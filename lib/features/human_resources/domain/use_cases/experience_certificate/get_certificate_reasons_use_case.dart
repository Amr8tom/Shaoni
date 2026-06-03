import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/experience_certificate/certificate_reason.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class GetCertificateReasonsUseCase
    extends UseCase<List<CertificateReason>, NoParams> {
  final HRServicesRepository _repository;

  GetCertificateReasonsUseCase(this._repository);

  @override
  Future<Either<Failure, List<CertificateReason>>> call({
    required NoParams params,
  }) async {
    return await _repository.getCertificateReasons(params: params);
  }
}
