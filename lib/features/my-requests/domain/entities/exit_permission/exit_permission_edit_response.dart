import 'package:equatable/equatable.dart';

import '../exit_permission.dart';

// Response shape:
// {
//   "success": true,
//   "message": "...",
//   "data": { ...exit permission fields... }
// }

class ExitPermissionEditResponse extends Equatable {
  final bool? success;
  final String? message;
  final ExitPermission? data;

  const ExitPermissionEditResponse({
    this.success,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [success, message, data];
}
