import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../entity/all_services.dart';
import '../entity/exit_permisstion.dart';
import '../entity/permission_time.dart';
import '../entity/permission_type.dart';
import '../use_cases/create_exit_permission_use_case.dart';

abstract class HRServicesRepository {
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
