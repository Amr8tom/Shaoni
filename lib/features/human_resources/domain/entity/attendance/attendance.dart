import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final bool success;
  final String? message;
  final String? requestNumber;

  const Attendance({
    required this.success,
    required this.message,
    required this.requestNumber,
  });

  @override
  List<Object?> get props => [success, message, requestNumber];
}
