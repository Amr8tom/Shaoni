import 'package:equatable/equatable.dart';

class CreateTrainingResponse extends Equatable {
  final String code;
  final String status;
  final String message;
  final int? trainingRequestLocalId;
  final int? trainingRequestId;
  final String? trainingRequestName;

  const CreateTrainingResponse({
    required this.code,
    required this.status,
    required this.message,
    this.trainingRequestLocalId,
    this.trainingRequestId,
    this.trainingRequestName,
  });

  @override
  List<Object?> get props => [
        code,
        status,
        message,
        trainingRequestLocalId,
        trainingRequestId,
        trainingRequestName,
      ];
}
