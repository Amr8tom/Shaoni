import 'package:equatable/equatable.dart';

/// Domain entity for a travel ticket class returned by
/// GET /Lookup/GetTravelTicketTypes (e.g. First/Business/Economy).
class TicketClass extends Equatable {
  final int id;
  final String name;

  const TicketClass({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
