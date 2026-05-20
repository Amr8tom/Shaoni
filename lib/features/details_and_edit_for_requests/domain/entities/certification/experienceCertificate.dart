


import 'package:equatable/equatable.dart';

class ExperienceCertificate extends Equatable{
  final String externalName;
  final String date;
  final String certificateReasonId;
  final String certificateReasonName;
  final String? reason;
  final String? note;
  final String? state;
  final String? certificateUrl;
  final String? editReasons;
  final String? rejectReasons;

  const ExperienceCertificate({
    required this.externalName,
    required this.date,
    required this.certificateReasonId,
    required this.certificateReasonName,
    required this.reason,
    required this.note,
    required this.state,
    required this.certificateUrl,
    required this.editReasons,
    required this.rejectReasons,

  });


  @override

  List<Object?> get props => [
    externalName,
    date,
    certificateReasonId,
    certificateReasonName,
    reason,
    note,
    state,
    certificateUrl,
    editReasons,
    rejectReasons,
  ];
}