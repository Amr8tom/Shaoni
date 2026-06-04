import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String? accessToken;
  final bool success;
  final String? userName;
  final String? role;
  final String? errors;
  final int? id;

  const LoginEntity(
      {required this.accessToken,
      required this.success,
      required this.userName,
      required this.role,
      required this.id,
      this.errors});

  @override
  List<Object?> get props => [accessToken, success, userName, role, errors, id];
}
