part of 'human_resources_cubit.dart';

final class HumanResourcesState extends Equatable {
  final GeneralStatus status;
  final List<Service>? services;

  const HumanResourcesState({ this.status=GeneralStatus.initialized , this.services});

  /// copy with method
  HumanResourcesState copyWith({GeneralStatus? status, List<Service>? services}) {
    return HumanResourcesState(
      status: status ?? this.status,
      services: services ?? this.services,
    );
  }

  @override
  List<Object?> get props => [status, services];
}
