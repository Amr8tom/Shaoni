import 'package:equatable/equatable.dart';

/// Domain entity representing a complaint reason returned by
/// `GET $baseUrl/Lookup/GetComplaintReasons`.
class ComplaintReason extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;

  const ComplaintReason({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}
