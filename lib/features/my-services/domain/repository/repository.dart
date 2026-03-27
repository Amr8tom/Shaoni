import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/my-services/data/model/permission_type_model.dart';
import 'package:shaoni/features/my-services/domain/entity/all_services.dart';
import 'package:shaoni/features/my-services/domain/entity/permission_time.dart';
import 'package:shaoni/features/my-services/domain/entity/permission_type.dart';

import '../../../../core/utils/usecases/base_usecase.dart';
import '../entity/exit_permisstion.dart';
import '../use_cases/create_exit_permission_use_case.dart';

abstract class ServicesRepository {
  Future<Either<Failure, AllServices>> getAllPermissionServices({
    required NoParams params,
  });

  Future<Either<Failure, ExitPermission>> createExitPermission({
    required CreateExitPermissionParams params,
  });

  Future<Either<Failure, List<PermissionType>>> getAllPermissionTypes({
    required NoParams params,
  });

  Future<Either<Failure, List<PermissionTime>>> getAllPermissionTimes({
    required NoParams params,
  });
}
