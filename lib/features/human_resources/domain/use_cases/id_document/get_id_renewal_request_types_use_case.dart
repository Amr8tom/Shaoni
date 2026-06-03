import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/id_document/id_renewal_request_type.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class GetIDRenewalRequestTypesUseCase
    extends UseCase<List<IDRenewalRequestType>, NoParams> {
  final HRServicesRepository _repository;

  GetIDRenewalRequestTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<IDRenewalRequestType>>> call({
    required NoParams params,
  }) async {
    return await _repository.getIDRenewalRequestTypes(params: params);
  }
}
