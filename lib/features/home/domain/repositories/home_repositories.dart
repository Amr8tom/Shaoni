import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/all_status_count.dart';

abstract class HomeRepositories {
  Future<Either<Failure, List<AllStatusCount>>> getAllStatusCountForAllServices(
      {required NoParams params});
}
