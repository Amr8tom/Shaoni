import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/auth/domain/entities/otp_response.dart';
import 'package:shaoni/features/auth/domain/repositories/auth_repositories.dart';

/// Asks the backend to mail a fresh verification code to [RequestOtpParams.email].
class RequestOtpUseCase extends UseCase<OtpResponse, RequestOtpParams> {
  final AuthRepositories _repository;

  RequestOtpUseCase(this._repository);

  @override
  Future<Either<Failure, OtpResponse>> call({
    required RequestOtpParams params,
  }) async {
    return _repository.requestOtp(params: params);
  }
}

class RequestOtpParams extends Equatable {
  final String email;

  const RequestOtpParams({required this.email});

  Map<String, dynamic> toJson() => {'email': email};

  @override
  List<Object?> get props => [email];
}
