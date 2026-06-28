import 'package:equatable/equatable.dart';

class StockRequestEntity extends Equatable {
  final int id;
  final String name;

  const StockRequestEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
