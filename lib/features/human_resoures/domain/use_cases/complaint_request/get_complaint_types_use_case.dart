import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/complaint_request/complaint_type.dart';
import '../../repository/repository.dart';

class GetComplaintTypesUseCase extends UseCase<List<ComplaintType>, NoParams> {
  final HRServicesRepository _repository;

  GetComplaintTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<ComplaintType>>> call({
    required NoParams params,
  }) async {
    return await _repository.getComplaintTypes(params: params);
  }
}
