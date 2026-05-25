import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/product_order/create_product_order_response.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';
import 'create_product_order_use_case.dart';

class UpdateProductOrderParams {
  final int requestId;
  final CreateProductOrderParams data;

  const UpdateProductOrderParams({
    required this.requestId,
    required this.data,
  });
}

class UpdateProductOrderUseCase {
  final HRServicesRepository _repository;

  const UpdateProductOrderUseCase(this._repository);

  Future<Either<Failure, CreateProductOrderResponse>> call({
    required UpdateProductOrderParams params,
  }) {
    return _repository.updateProductOrder(params: params);
  }
}
