import 'package:equatable/equatable.dart';

/// "office": { "id": 21, "name": "المستودع الرئيسي (MW)" },

class OfficeEntity extends Equatable {
  final int id;
  final String name;

  const OfficeEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
