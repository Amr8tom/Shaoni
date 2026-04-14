import 'package:equatable/equatable.dart';

class NewPassword extends Equatable {
  final bool success;
  final String message;
  final String? error;

  const NewPassword({
    required this.success,
    required this.message,
    required this.error,
  });

  @override
  List<Object?> get props => [success, message, error];
}
