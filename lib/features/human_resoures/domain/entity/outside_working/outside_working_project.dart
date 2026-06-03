import 'package:equatable/equatable.dart';

class OutsideWorkingProject extends Equatable {
  final int id;
  final String name;

  const OutsideWorkingProject({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
