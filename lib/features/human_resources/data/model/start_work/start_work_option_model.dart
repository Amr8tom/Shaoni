import '../../../domain/entity/start_work/start_work_option.dart';

class StartWorkOptionModel extends StartWorkOption {
  const StartWorkOptionModel({required super.id, required super.name});

  factory StartWorkOptionModel.fromJson(Map<String, dynamic> json) {
    return StartWorkOptionModel(
      id: json['id'] as int? ?? 0,
      name: (json['name'] ?? '').toString(),
    );
  }
}
