import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_reason_entity.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class GetScrapReasonsUseCase
    extends UseCase<List<ScrapReasonEntity>, NoParams> {
  final HRServicesRepository _repository;

  GetScrapReasonsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ScrapReasonEntity>>> call({
    required NoParams params,
  }) async {
    return await _repository.getScrapReasons();
  }
}
