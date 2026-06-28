import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/stock_request_entity.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class GetStockRequestsUseCase
    extends UseCase<List<StockRequestEntity>, NoParams> {
  final HRServicesRepository _repository;

  GetStockRequestsUseCase(this._repository);

  @override
  Future<Either<Failure, List<StockRequestEntity>>> call({
    required NoParams params,
  }) async {
    return await _repository.getStockRequests();
  }
}
