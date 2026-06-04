part of 'services_cubit.dart';

final class ServicesState extends Equatable {
  final GeneralStatus status;
  final List<Service>? services;
  final List<Service>? hrServices;
  final List<Service>? studyServices;
  final List<Service>? purchasesServices;
  final List<Service>? salariesServices;
  final List<Service>? reservationsServices;

  const ServicesState({
    this.status = GeneralStatus.initialized,
    this.services,
    this.hrServices,
    this.studyServices,
    this.purchasesServices,
    this.salariesServices,
    this.reservationsServices,
  });

  /// copy with method
  ServicesState copyWith({
    GeneralStatus? status,
    List<Service>? services,
    List<Service>? hrServices,
    List<Service>? studyServices,
    List<Service>? purchasesServices,
    List<Service>? salariesServices,
    List<Service>? reservationsServices,
  }) {
    return ServicesState(
      status: status ?? this.status,
      services: services ?? this.services,
      hrServices: hrServices ?? this.hrServices,
      studyServices: studyServices ?? this.studyServices,
      purchasesServices: purchasesServices ?? this.purchasesServices,
      salariesServices: salariesServices ?? this.salariesServices,
      reservationsServices: reservationsServices ?? this.reservationsServices,
    );
  }

  @override
  List<Object?> get props => [
        status,
        services,
        hrServices,
        studyServices,
        purchasesServices,
        salariesServices,
        reservationsServices
      ];
}
