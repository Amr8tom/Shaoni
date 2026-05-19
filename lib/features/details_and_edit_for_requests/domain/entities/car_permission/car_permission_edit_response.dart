import 'package:equatable/equatable.dart';

import 'car_permission.dart';

// Response shape:
// {
//   "success": true,
//   "message": "...",
//   "data": { ...car permission fields... }
// }

class CarPermissionEditResponse extends Equatable {
  final bool? success;
  final String? message;
  final CarPermission? data;

  const CarPermissionEditResponse({
    this.success,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [success, message, data];
}
