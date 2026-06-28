import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/create_scrap_request_response.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';
import 'create_scrap_request_use_case.dart';

class UpdateScrapRequestUseCase
    extends UseCase<CreateScrapRequestResponse, UpdateScrapRequestParams> {
  final HRServicesRepository _repository;

  UpdateScrapRequestUseCase(this._repository);

  @override
  Future<Either<Failure, CreateScrapRequestResponse>> call({
    required UpdateScrapRequestParams params,
  }) async {
    return await _repository.updateScrapRequest(params: params);
  }
}

class UpdateScrapRequestParams extends Equatable {
  final int requestId;
  final CreateScrapRequestParams data;

  const UpdateScrapRequestParams({
    required this.requestId,
    required this.data,
  });

  @override
  List<Object?> get props => [requestId, data];
}
