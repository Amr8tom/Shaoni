import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/profile/domain/entities/profile.dart';

import '../use_cases/update_profile_use_case.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> updateProfile(
      {required UpdateProfileParams params});
}
