import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../use_cases/get_user_data_use_case.dart';

abstract class NavigationRepository {
  /// getCountUnreadedNotification
  Future<Either<Failure, int>> getCountUnreadedNotification();
  Future<Either<Failure, UserEntity>> getUserData(
      {required GetUserDataParams params});
}
