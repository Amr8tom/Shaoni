import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/navigation/domain/repositories/repositories.dart';

class GetCountUnreadedNotificationUseCase extends UseCase<int, NoParams> {
  final NavigationRepository _repository;

  GetCountUnreadedNotificationUseCase(this._repository);

  @override
  Future<Either<Failure, int>> call({required NoParams params}) async {
    return await _repository.getCountUnreadedNotification();
  }
}
