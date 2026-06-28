import 'package:equatable/equatable.dart';

class CreateScrapRequestResponse extends Equatable {
  final bool success;
  final String message;
  final int? requestId;
  final String? requestName;

  const CreateScrapRequestResponse({
    required this.success,
    required this.message,
    this.requestId,
    this.requestName,
  });

  @override
  List<Object?> get props => [success, message, requestId, requestName];
}
