import 'package:equatable/equatable.dart';

class CurrentStatus extends Equatable {
  final String? nameAr;
  final String? nameEn;
  final String? colorHex;
  final String? techName;
  const CurrentStatus({
    this.nameAr,
    this.nameEn,
    this.techName,
    this.colorHex,
  });

  @override
  List<Object?> get props => [nameAr, colorHex, nameEn, techName];
}
