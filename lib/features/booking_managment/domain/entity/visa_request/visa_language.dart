import 'package:equatable/equatable.dart';

/// Domain entity for an active language returned by
/// GET /Integration/get-active-languages
class VisaLanguage extends Equatable {
  final int id;
  final String name;

  const VisaLanguage({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
