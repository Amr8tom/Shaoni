import 'package:equatable/equatable.dart';

// {
// "success": true,
// "message": "Profile updated successfully",
// "error": null
// }

class Profile extends Equatable {
  final bool success;
  final String message;
  final String? errorMassage;
  const Profile(
      {required this.success, required this.message, this.errorMassage});

  @override
  List<Object?> get props => [success, message, errorMassage];
}
