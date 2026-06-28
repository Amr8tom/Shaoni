import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_custody.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class GetCustodiesUseCase
    extends UseCase<List<ScrapCustody>, GetCustodiesParams> {
  final HRServicesRepository _repository;

  GetCustodiesUseCase(this._repository);

  @override
  Future<Either<Failure, List<ScrapCustody>>> call({
    required GetCustodiesParams params,
  }) async {
    return await _repository.getCustodies(params: params);
  }
}

class GetCustodiesParams extends Equatable {
  final int employeeId;

  const GetCustodiesParams({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}
