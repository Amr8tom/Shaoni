import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_language.dart';

class VisaLanguageModel extends VisaLanguage {
  const VisaLanguageModel({required super.id, required super.name});

  factory VisaLanguageModel.fromJson(Map<String, dynamic> json) {
    return VisaLanguageModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
