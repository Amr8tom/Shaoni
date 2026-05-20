import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/start_work/create_start_work_response.dart';
import '../../repository/repository.dart';
import 'create_start_work_use_case.dart';

class UpdateStartWorkUseCase
    extends UseCase<CreateStartWorkResponse, UpdateStartWorkParams> {
  final HRServicesRepository repository;

  UpdateStartWorkUseCase(this.repository);

  @override
  Future<Either<Failure, CreateStartWorkResponse>> call({
    required UpdateStartWorkParams params,
  }) async {
    return await repository.updateStartWorkRequest(params: params);
  }
}

class UpdateStartWorkParams {
  final int requestId;
  final CreateStartWorkParams data;

  const UpdateStartWorkParams({
    required this.requestId,
    required this.data,
  });

  Map<String, dynamic> toMap() => data.toMap();
}
