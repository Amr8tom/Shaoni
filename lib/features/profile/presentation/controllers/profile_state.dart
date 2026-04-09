part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final int gender; // 1 for Male, 2 for Female
  final int nationality; // 1 for Saudi, 2 for Non-Saudi
  final int city; // 1 for Jeddah, 2 for Makka
  final GeneralStatus status;
  final String? massage;

  const ProfileState({
    this.gender = 1,
    this.nationality = 1,
    this.city = 1,
    this.massage,
    this.status = GeneralStatus.initialized,
  });

  ProfileState copyWith({
    int? gender,
    int? nationality,
    GeneralStatus? status,
    String? massage,
    int? city,
  }) {
    return ProfileState(
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      city: city ?? this.city,
      status: status ?? this.status,
      massage: massage ?? this.massage,
    );
  }

  @override
  List<Object?> get props => [gender, nationality, city,status,massage];
}
