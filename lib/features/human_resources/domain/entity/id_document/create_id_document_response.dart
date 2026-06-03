import 'package:equatable/equatable.dart';

class CreateIDDocumentResponse extends Equatable {
  final bool success;
  final String? message;
  final int requestId;

  const CreateIDDocumentResponse({
    required this.success,
    this.message,
    required this.requestId,
  });

  @override
  List<Object?> get props => [success, message, requestId];
}
