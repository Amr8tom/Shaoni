import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/auth/domain/entities/otp_response.dart';
import 'package:shaoni/features/auth/domain/repositories/auth_repositories.dart';

/// Validates the code the user typed against the one that was mailed to them.
class VerifyOtpUseCase extends UseCase<OtpResponse, VerifyOtpParams> {
  final AuthRepositories _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, OtpResponse>> call({
    required VerifyOtpParams params,
  }) async {
    return _repository.verifyOtp(params: params);
  }
}

class VerifyOtpParams extends Equatable {
  final String email;
  final String code;

  const VerifyOtpParams({required this.email, required this.code});

  Map<String, dynamic> toJson() => {'email': email, 'code': code};

  @override
  List<Object?> get props => [email, code];
}
