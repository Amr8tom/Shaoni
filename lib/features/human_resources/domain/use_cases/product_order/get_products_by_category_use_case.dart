import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/product_order/product.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class GetProductsByCategoryUseCase
    extends UseCase<List<OdooProduct>, GetProductsByCategoryParams> {
  final HRServicesRepository _repository;

  GetProductsByCategoryUseCase(this._repository);

  @override
  Future<Either<Failure, List<OdooProduct>>> call({
    required GetProductsByCategoryParams params,
  }) async {
    return await _repository.getProductsByCategory(params: params);
  }
}

class GetProductsByCategoryParams extends Equatable {
  /// Null means "fetch all products" (no category filter).
  final int? categoryId;

  const GetProductsByCategoryParams({this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}
