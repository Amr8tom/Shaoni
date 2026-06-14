import 'package:equatable/equatable.dart';

class CreateLoanResponse extends Equatable {
  final bool success;
  final String message;
  final int? requestId;

  const CreateLoanResponse({
    required this.success,
    required this.message,
    this.requestId,
  });

  @override
  List<Object?> get props => [success, message, requestId];
}
