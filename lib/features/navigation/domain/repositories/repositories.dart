import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class NavigationRepository
{
  /// getCountUnreadedNotification
  Future<Either<Failure, int>> getCountUnreadedNotification();
}
