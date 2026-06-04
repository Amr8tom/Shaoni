import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../repositories/repositories.dart';

class GetUserDataUseCase {
  final NavigationRepository _repository;

  const GetUserDataUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call({
    required GetUserDataParams params,
  }) async {
    return _repository.getUserData(params: params);
  }
}

class GetUserDataParams {
  final String id;

  const GetUserDataParams({required this.id});

  /// toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
