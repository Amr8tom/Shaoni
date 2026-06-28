import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_lot.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class GetProductLotsUseCase
    extends UseCase<List<ScrapLot>, GetProductLotsParams> {
  final HRServicesRepository _repository;

  GetProductLotsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ScrapLot>>> call({
    required GetProductLotsParams params,
  }) async {
    return await _repository.getProductLots(params: params);
  }
}

class GetProductLotsParams extends Equatable {
  final int productId;

  const GetProductLotsParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}
