import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/profile/domain/entities/profile.dart';
import '../repositories/repository.dart';

class UpdateProfileUseCase extends UseCase<Profile, UpdateProfileParams> {
  final ProfileRepository _repository;
  UpdateProfileUseCase(this._repository);
  @override
  Future<Either<Failure, Profile>> call(
      {required UpdateProfileParams params}) async {
    return await _repository.updateProfile(params: params);
  }
}

class UpdateProfileParams extends Equatable {
  final String fullName;
  final String phoneNumber;
  final int nationalityId;
  final int cityId;
  final int genderId;

  UpdateProfileParams({
    required this.fullName,
    required this.phoneNumber,
    required this.nationalityId,
    required this.cityId,
    required this.genderId,
  });

  /// toMap
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'nationalityId': nationalityId,
      'cityId': cityId,
      'genderId': genderId,
    };
  }

  @override
  List<Object?> get props =>
      [fullName, phoneNumber, nationalityId, cityId, genderId];
}
