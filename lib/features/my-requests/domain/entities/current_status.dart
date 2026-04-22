import 'package:equatable/equatable.dart';

class CurrentStatus extends Equatable{
  final String? nameAr;
  final String? nameEn;
  final String? colorHex;
  const CurrentStatus({
    this.nameAr,
    this.nameEn,
    this.colorHex,
  });

/// fromJson
  factory CurrentStatus.fromJson(Map<String, dynamic> json) {
    return CurrentStatus(
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      colorHex: json['colorHex'],
    );

  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'colorHex': colorHex,
    };
  }

  @override
  List<Object?> get props => [nameAr, colorHex, nameEn];
}