import 'package:equatable/equatable.dart';

class ScrapReasonEntity extends Equatable {
  final int id;
  final String name;

  const ScrapReasonEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
