import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/experience_certificate/create_experience_certificate_response.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';
import 'create_experience_certificate_use_case.dart';

class UpdateExperienceCertificateUseCase extends UseCase<
    CreateExperienceCertificateResponse, UpdateExperienceCertificateParams> {
  final HRServicesRepository _repository;

  UpdateExperienceCertificateUseCase(this._repository);

  @override
  Future<Either<Failure, CreateExperienceCertificateResponse>> call({
    required UpdateExperienceCertificateParams params,
  }) async {
    return await _repository.updateExperienceCertificate(params: params);
  }
}

class UpdateExperienceCertificateParams extends Equatable {
  final int requestId;
  final CreateExperienceCertificateParams data;

  const UpdateExperienceCertificateParams({
    required this.requestId,
    required this.data,
  });

  Map<String, dynamic> toMap() => data.toMap();

  @override
  List<Object?> get props => [requestId, data];
}
