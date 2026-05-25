import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/product_order/product_category.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class GetProductCategoriesUseCase extends UseCase<List<ProductCategory>, NoParams> {
  final HRServicesRepository _repository;

  GetProductCategoriesUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProductCategory>>> call({
    required NoParams params,
  }) async {
    return await _repository.getProductCategories();
  }
}
