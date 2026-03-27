part of 'my_services_cubit.dart';

final class MyServicesState extends Equatable {
  final GeneralStatus status;
  final List<Service>? services;

  const MyServicesState({ this.status=GeneralStatus.initialized , this.services});

  /// copy with method
  MyServicesState copyWith({GeneralStatus? status, List<Service>? services}) {
    return MyServicesState(
      status: status ?? this.status,
      services: services ?? this.services,
    );
  }

  @override
  List<Object?> get props => [status, services];
}
