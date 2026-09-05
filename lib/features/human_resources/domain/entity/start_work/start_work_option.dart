import 'package:equatable/equatable.dart';

/// A simple `{id, name}` lookup option used by the start-work conditional
/// dropdowns (employee contracts, task management).
class StartWorkOption extends Equatable {
  final int id;
  final String name;

  const StartWorkOption({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
