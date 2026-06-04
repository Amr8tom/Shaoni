import 'package:shaoni/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel(
      {required super.success, required super.message, super.errorMassage});

  /// fromJson
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] == true) {
      return ProfileModel(
          success: json['success'],
          message: json['message'],
          errorMassage: json['error']);
    } else {
      return ProfileModel(
          success: json['success'],
          message: json['message'] ?? '',
          errorMassage:
              json['error'] != null ? json['error']['message'] : null);
    }
  }
}
