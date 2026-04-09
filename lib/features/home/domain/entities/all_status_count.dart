import 'package:equatable/equatable.dart';
import 'package:shaoni/features/home/data/model/status_count_model.dart';



class AllStatusCount extends Equatable {
  final int? serviceId;
  final String? serviceCode;
  final String? serviceNameAr;
  final String? serviceNameEn;
  final List<StatusCountModel>? statusCounts;

  const AllStatusCount(
      {required this.serviceId,
      required this.serviceCode,
      required this.serviceNameAr,
      required this.serviceNameEn,
      required this.statusCounts});
  @override
  List<Object?> get props =>
      [serviceId, serviceCode, serviceNameAr, serviceNameEn, statusCounts];
}
