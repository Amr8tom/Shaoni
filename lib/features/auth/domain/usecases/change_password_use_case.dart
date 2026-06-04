import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/auth/domain/repositories/auth_repositories.dart';

import '../entities/new_password.dart';

class ChangePasswordUseCase extends UseCase<NewPassword, NewPasswordParams> {
  final AuthRepositories _repository;

  ChangePasswordUseCase(this._repository);

  @override
  Future<Either<Failure, NewPassword>> call(
      {required NewPasswordParams params}) async {
    return await _repository.changePassword(params: params);
  }
}

class NewPasswordParams extends Equatable {
  final String newPassword;
  final String userID;

  const NewPasswordParams({
    required this.newPassword,
    required this.userID,
  });

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'newPassword': newPassword,
      'uId': userID,
    };
  }

  @override
  List<Object?> get props => [newPassword, userID];
}
