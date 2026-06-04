import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/auth/domain/entities/user_entity.dart';
import 'package:shaoni/features/home/data/model/all_status_count_model.dart';

import '../../../navigation/domain/use_cases/get_user_data_use_case.dart';
import '../entities/all_status_count.dart';

abstract class HomeRepositories {
  Future<Either<Failure, List<AllStatusCount>>> getAllStatusCountForAllServices(
      {required NoParams params});
}
