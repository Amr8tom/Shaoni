import 'package:equatable/equatable.dart';

class ForgetReason extends Equatable {
  final int id;
  final String? name;
  final String? nameEn;

  const ForgetReason({
    required this.id,
    required this.name,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, name, nameEn];
}
