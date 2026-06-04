import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/home/domain/entities/all_status_count.dart';

import '../repositories/home_repositories.dart';

class GetAllStatusCountsUseCase
    extends UseCase<List<AllStatusCount>, NoParams> {
  final HomeRepositories repositories;

  GetAllStatusCountsUseCase(this.repositories);

  @override
  Future<Either<Failure, List<AllStatusCount>>> call(
      {required NoParams params}) async {
    return await repositories.getAllStatusCountForAllServices(params: params);
  }
}
