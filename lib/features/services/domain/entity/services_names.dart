import 'package:equatable/equatable.dart';

class ServicesNames extends Equatable{
  static List<String> hrServiceKeys = [
    "outside.working",
    "attendance.update",
    "hr.exit.permission",
    "school.permission",
    "car.permission",
    "end.of.service",
    "clearance.request",
    "start.work",
    "id.renewal.request",
    "profile.update.request",
    "upgrade.medical.insurance",
    "experience.certificate",
    "complaint.request",
  ];
  static List<String> studyServiceKeys = [
    "study.request",
    "training.request",
  ];
  static List<String> productServiceKeys = [
    "product.request",
  ];
  @override
  List<Object?> get props => [];
}