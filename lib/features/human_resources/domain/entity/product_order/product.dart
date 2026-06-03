import 'package:equatable/equatable.dart';

class OdooProduct extends Equatable {
  final int id;
  final String name;

  const OdooProduct({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
