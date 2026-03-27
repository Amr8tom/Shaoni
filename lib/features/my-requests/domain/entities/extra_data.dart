import 'package:equatable/equatable.dart';

import '../../../my-services/domain/entity/exit_permisstion.dart';

//  {
// "attendance": null,
// "study": null,
// "outsideWorking": null,
// "visaRequest": null,
// "exitPermission": {
// "id": 40,
// "exitDate": "2026-03-29T00:00:00",
// "numberOfHours": 1,
// "permissionTimeValue": "med",
// "permissionType": 2,
// "notes": "tejst",
// "leavesAttachment": null
// }
// }

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
          : null,git
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
