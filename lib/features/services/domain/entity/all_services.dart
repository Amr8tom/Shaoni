import 'package:equatable/equatable.dart';

import 'service.dart';

class AllServices extends Equatable {
  final List<Service> services;

  const AllServices({required this.services});

  @override
  List<Object?> get props => [services];
}
