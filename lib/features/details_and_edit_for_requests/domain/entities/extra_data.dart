import 'package:equatable/equatable.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/study/study.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/start_work.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/certification/experience_certificate.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/id_document.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/medical_insurance/medical_insurance_details.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/training_request.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/product_order.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/car_permission/car_permission.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/complaint_request/complaint_request_details.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/attendance/attendance_request_details.dart';

import '../../../human_resources/domain/entity/exit_permisstion.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/salary_request.dart';

class ExtraData extends Equatable {
  final AttendanceRequestDetails? attendance;
  final Study? study;
  final StartWork? startWork;
  final ExperienceCertificate? experienceCertificate;
  final IDDocument? idDocument;
  final MedicalInsuranceDetails? medicalInsurance;
  final TrainingRequest? trainingRequest;
  final ProductOrderEntity? productOrder;
  final String? outsideWorking;
  final String? visaRequest;
  final ExitPermission? exitPermission;
  final CarPermission? carPermission;
  final ComplaintRequestDetails? complaintRequest;
  final SalaryRequest? salaryRequest;

  const ExtraData({
    this.carPermission,
    this.attendance,
    this.study,
    this.startWork,
    this.experienceCertificate,
    this.idDocument,
    this.medicalInsurance,
    this.trainingRequest,
    this.productOrder,
    this.outsideWorking,
    this.visaRequest,
    this.exitPermission,
    this.complaintRequest,
    this.salaryRequest,
  });

  @override
  List<Object?> get props => [
        attendance,
        carPermission,
        complaintRequest,
        study,
        startWork,
        experienceCertificate,
        idDocument,
        medicalInsurance,
        trainingRequest,
        productOrder,
        outsideWorking,
        visaRequest,
        exitPermission,
        salaryRequest,
      ];
}
