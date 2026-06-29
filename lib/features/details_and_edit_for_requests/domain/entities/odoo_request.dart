import 'package:equatable/equatable.dart';

class OdooRequest extends Equatable {
  final bool success;
  final String code;
  final String status;
  final String? message;
  final int? externalId;
  final String? externalName;
  final String? externalState;
  final String? externalStateId;

  const OdooRequest({
    required this.success,
    required this.code,
    required this.status,
    required this.message,
    required this.externalId,
    required this.externalName,
    required this.externalState,
    required this.externalStateId,
  });

  @override
  List<Object?> get props => [
        success,
        code,
        status,
        message,
        externalId,
        externalName,
        externalState,
        externalStateId
      ];
}
