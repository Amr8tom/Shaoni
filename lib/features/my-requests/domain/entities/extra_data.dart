import 'package:equatable/equatable.dart';

import '../../../human_resoures/domain/entity/exit_permisstion.dart';
class ExtraData extends Equatable {
  final String? attendance;
  final String? study;
  final String? outsideWorking;
  final String? visaRequest;
  final ExitPermission? exitPermission;

  const ExtraData({
    this.attendance,
    this.study,
    this.outsideWorking,
    this.visaRequest,
    this.exitPermission,
  });
  /// fromJson
  factory ExtraData.fromJson(Map<String, dynamic> json) {
    return ExtraData(
      attendance: json['attendance'],
      study: json['study'],
      outsideWorking: json['outsideWorking'],
      visaRequest: json['visaRequest'],
      exitPermission: json['exitPermission'] != null
          ? ExitPermission.fromJson(json['exitPermission'])
          : null,
    );
  }
  /// to json
  Map<String, dynamic> toJson() {
    return {
      'attendance': attendance,
      'study': study,
      'outsideWorking': outsideWorking,
      'visaRequest': visaRequest,
      'exitPermission': exitPermission?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    attendance,
    study,
    outsideWorking,
    visaRequest,
    exitPermission,
  ];
}
