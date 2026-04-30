part of 'study_cubit.dart';

final class StudyState extends Equatable {
  final GeneralStatus status;

  const StudyState({this.status = GeneralStatus.initialized});

  /// copy with
  StudyState copyWith({GeneralStatus? status}) {
    return StudyState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
