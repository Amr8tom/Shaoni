part of 'services_cubit.dart';

final class ServicesState extends Equatable {
  final GeneralStatus status;
  final List<Service>? services;
  final List<Service>? HRservices;
  final List<Service>? Studyservices;
  final List<Service>? purchasesServices;
  final List<Service>? salariesServices;
  final List<Service>? reservationsServices;

  const ServicesState({
    this.status = GeneralStatus.initialized,
    this.services,
    this.HRservices,
    this.Studyservices,
    this.purchasesServices,
    this.salariesServices,
    this.reservationsServices,
  });

  /// copy with method
  ServicesState copyWith({
    GeneralStatus? status,
    List<Service>? services,
    List<Service>? HRservices,
    List<Service>? Studyservices,
    List<Service>? purchasesServices,
    List<Service>? salariesServices,
    List<Service>? reservationsServices,
  }) {
    return ServicesState(
      status: status ?? this.status,
      services: services ?? this.services,
      HRservices: HRservices ?? this.HRservices,
      Studyservices: Studyservices ?? this.Studyservices,
      purchasesServices: purchasesServices ?? this.purchasesServices,
      salariesServices: salariesServices ?? this.salariesServices,
      reservationsServices: reservationsServices ?? this.reservationsServices,
    );
  }

  @override
  List<Object?> get props => [
        status,
        services,
        HRservices,
        Studyservices,
        purchasesServices,
        salariesServices,
        reservationsServices
      ];
}
