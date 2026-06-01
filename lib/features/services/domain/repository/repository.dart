import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../entity/all_services.dart';


abstract class ServicesRepository {
  Future<Either<Failure, AllServices>> getAllPermissionServices({
    required NoParams params,
  });
}
