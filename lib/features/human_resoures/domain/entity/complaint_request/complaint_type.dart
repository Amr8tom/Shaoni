import 'package:equatable/equatable.dart';

/// Domain entity representing a complaint type returned by
/// `GET $baseUrl/Lookup/GetComplaintTypes`.
class ComplaintType extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;

  const ComplaintType({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}
