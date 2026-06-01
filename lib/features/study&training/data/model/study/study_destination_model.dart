
import '../../../domain/entities/study/study_destination.dart';

class StudyDestinationModel extends StudyDestination {
  const StudyDestinationModel({
    required super.id,
    required super.name,
  });

  factory StudyDestinationModel.fromJson(Map<String, dynamic> json) {
    return StudyDestinationModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
