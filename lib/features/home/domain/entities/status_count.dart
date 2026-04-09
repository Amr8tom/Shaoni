import 'package:equatable/equatable.dart';

// {
// "statusId": 13,
// "nameAr": "جديد",
// "nameEn": "New",
// "techName": "new",
// "count": 20
// },

class StatusCount extends Equatable {
  final int? statusId;
  final String? nameAr;
  final String? nameEn;
  final String? techName;
  final int? count;

  const StatusCount({
    required this.statusId,
    required this.nameAr,
    required this.nameEn,
    required this.techName,
    required this.count,
  });

  @override
  List<Object?> get props => [statusId, nameAr, nameEn, techName, count];
}
