import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/auth/domain/repositories/auth_repositories.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../entities/login.dart';

class LoginUseCase extends UseCase<LoginEntity, LoginParams> {
  final AuthRepositories _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginEntity>> call({required LoginParams params}) {
    return _repository.login(params: params);
  }
}

class LoginParams extends Equatable {
  final String userName, password;

  const LoginParams({required this.userName, required this.password});

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }


  @override
  List<Object?> get props => [userName, password];
}
