import 'package:equatable/equatable.dart';

class CreateMedicalInsuranceResponse extends Equatable {
  final bool success;
  final String? message;
  final int requestId;

  const CreateMedicalInsuranceResponse({
    required this.success,
    this.message,
    required this.requestId,
  });

  @override
  List<Object?> get props => [success, message, requestId];
}
