import 'package:equatable/equatable.dart';

/// Domain entity for a study destination returned by
/// GET /Integration/get-study-Destinations
class StudyDestination extends Equatable {
  final int id;
  final String name;

  const StudyDestination({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
