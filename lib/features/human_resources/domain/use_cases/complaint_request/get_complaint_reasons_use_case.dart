import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/complaint_request/complaint_reason.dart';
import '../../repository/repository.dart';

class GetComplaintReasonsUseCase
    extends UseCase<List<ComplaintReason>, NoParams> {
  final HRServicesRepository _repository;

  GetComplaintReasonsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ComplaintReason>>> call({
    required NoParams params,
  }) async {
    return await _repository.getComplaintReasons(params: params);
  }
}
