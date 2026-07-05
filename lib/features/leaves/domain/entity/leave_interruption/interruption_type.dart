import 'package:equatable/equatable.dart';

/// Domain entity for a leave-interruption type returned by
/// GET /Lookup/GetInterruptionLeaveTypes
class InterruptionType extends Equatable {
  final int id;
  final String name;

  const InterruptionType({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
