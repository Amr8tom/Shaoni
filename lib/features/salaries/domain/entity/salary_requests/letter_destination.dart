import 'package:equatable/equatable.dart';

class LetterDestination extends Equatable {
  final int id;
  final String name;

  const LetterDestination({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
