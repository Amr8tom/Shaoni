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

  /// fromJson
  factory CurrentStatus.fromJson(Map<String, dynamic> json) {
    return CurrentStatus(
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      techName: json['techName'],
      colorHex: json['colorHex'],
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'techName': techName,
      'colorHex': colorHex,
    };
  }

  @override
  List<Object?> get props => [nameAr, colorHex, nameEn, techName];
}
