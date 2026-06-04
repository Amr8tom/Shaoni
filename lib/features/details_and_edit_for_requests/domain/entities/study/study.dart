// "study": {
// flutter: ║                 "requestType": "",
// flutter: ║                 "requestTypeLabel": null,
// flutter: ║                 "study": "jjj",
// flutter: ║                 "studyDestinationsText": "Study Destination 02",
// flutter: ║                 "studyDestinationId": 2,
// flutter: ║                 "studyStartDate": "2026-05-21T00:00:00",
// flutter: ║                 "studyEndDate": "2026-06-10T00:00:00",
// flutter: ║                 "note": "",
// flutter: ║                 "reason": "kkkk",
// flutter: ║                 "comment": "false",
// flutter: ║                 "editReasons": null,
// flutter: ║                 "rejectReasons": null,
// flutter: ║                 "attachments": []
// flutter: ║            }

import 'package:equatable/equatable.dart';

class Study extends Equatable {
  final String? requestType;
  final String? requestTypeLabel;
  final String? study;
  final String? studyDestinationsText;
  final int? studyDestinationId;
  final String? studyStartDate;
  final String? studyEndDate;
  final String? note;
  final String? reason;
  final String? comment;
  final String? editReasons;
  final String? rejectReasons;
  final List<String>? attachments;

  const Study({
    this.requestType,
    this.requestTypeLabel,
    this.study,
    this.studyDestinationsText,
    this.studyDestinationId,
    this.studyStartDate,
    this.studyEndDate,
    this.note,
    this.reason,
    this.comment,
    this.editReasons,
    this.rejectReasons,
    this.attachments,
  });

  @override
  List<Object?> get props => [
        requestType,
        requestTypeLabel,
        study,
        studyDestinationsText,
        studyDestinationId,
        studyStartDate,
        studyEndDate,
        note,
        reason,
        comment,
        editReasons,
        rejectReasons,
        attachments,
      ];
}
