import 'package:equatable/equatable.dart';

class OutsideWorkingEmployee extends Equatable {
  final int id;
  final String name;

  const OutsideWorkingEmployee({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
