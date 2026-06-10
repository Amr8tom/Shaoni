import '../../../domain/entity/salary_requests/letter_destination.dart';

class LetterDestinationModel extends LetterDestination {
  const LetterDestinationModel({
    required super.id,
    required super.name,
  });

  factory LetterDestinationModel.fromJson(Map<String, dynamic> json) {
    return LetterDestinationModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(LetterDestination entity) {
    return {
      'id': entity.id,
      'name': entity.name,
    };
  }
}
