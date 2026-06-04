import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/attendance/forget_reason.dart';

import '../../repository/repository.dart';

class GetForgetReasonUseCase extends UseCase<List<ForgetReason>, NoParams> {
  final HRServicesRepository _repository;

  GetForgetReasonUseCase(this._repository);

  @override
  Future<Either<Failure, List<ForgetReason>>> call(
      {required NoParams params}) async {
    return _repository.getForgetReason(params: NoParams());
  }
}
