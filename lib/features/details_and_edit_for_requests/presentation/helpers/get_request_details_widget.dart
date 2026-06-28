import 'package:flutter/cupertino.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/service_codes.dart';
import '../widgets/attendance_request_details_widget.dart';
import '../widgets/car_permission_details_widget.dart';
import '../widgets/complaint_request_details_widget.dart';
import '../widgets/exit_permission_details_widget.dart';
import '../widgets/study_request_details_widget.dart';
import '../widgets/start_work_request_details_widget.dart';
import '../widgets/experience_certificate_details_widget.dart';
import '../widgets/id_document_details_widget.dart';
import '../widgets/medical_insurance_details_widget.dart';
import '../widgets/training_request_details_widget.dart';
import '../widgets/product_order_details_widget.dart';
import '../widgets/loan_details_widget.dart';
import '../widgets/outside_working_details_widget.dart';
import '../widgets/salary_transfer_details_widget.dart';
import '../widgets/scrap_request_details_widget.dart';
import '../widgets/visa_request_details_widget.dart';

Widget getRequestDetailsWidget({required String serviceCode}) {
  switch (ServiceCode.fromCode(serviceCode)) {
    case ServiceCode.carPermission:
      return const CarPermissionDetailsWidget();
    case ServiceCode.complaintRequest:
      return const ComplaintRequestDetailsWidget();
    case ServiceCode.exitPermission:
      return const ExitPermissionDetailsWidget();
    case ServiceCode.attendanceUpdate:
      return const AttendanceRequestDetailsWidget();
    case ServiceCode.studyRequest:
      return const StudyRequestDetailsWidget();
    case ServiceCode.startWork:
      return const StartWorkRequestDetailsWidget();
    case ServiceCode.experienceCertificate:
      return const ExperienceCertificateDetailsWidget();
    case ServiceCode.idRenewalRequest:
      return const IDDocumentDetailsWidget();
    case ServiceCode.medicalInsuranceUpgrade:
      return const MedicalInsuranceDetailsWidget();
    case ServiceCode.trainingRequest:
      return const TrainingRequestDetailsWidget();
    case ServiceCode.productRequest:
      return const ProductOrderDetailsWidget();
    case ServiceCode.outsideWorking:
      return const OutsideWorkingDetailsWidget();
    case ServiceCode.salaryTransfer:
      return const SalaryTransferDetailsWidget();
    case ServiceCode.loan:
      return const LoanDetailsWidget();
    case ServiceCode.scrapRequest:
      return const ScrapRequestDetailsWidget();
    case ServiceCode.visaRequest:
      return const VisaRequestDetailsWidget();
    default:
      return const Sizer();
  }
}
