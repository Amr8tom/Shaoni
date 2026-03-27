import 'package:equatable/equatable.dart';
import 'package:shaoni/features/my-services/data/model/service_model.dart';

class AllServices extends Equatable {
  final List<ServiceModel> services;

  const AllServices({required this.services});

  @override
  List<Object?> get props => [services];
}
