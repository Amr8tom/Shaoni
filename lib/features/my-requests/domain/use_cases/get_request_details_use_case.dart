import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/request_with_stage.dart';
import '../repositories/repository.dart';

class GetRequestDetailsUseCase
    extends UseCase<RequestWithStage, GetRequestDetailsParams> {
  final MyRequestsRepository repository;

  GetRequestDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, RequestWithStage>> call(
      {required GetRequestDetailsParams params}) async {
    return await repository.getRequestDetails(params: params);
  }
}

class GetRequestDetailsParams extends Equatable {
  final int requestId;

  const GetRequestDetailsParams({
    required this.requestId,
  });

  /// to Json
  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
    };
  }

  @override
  List<Object?> get props => [requestId];
}
