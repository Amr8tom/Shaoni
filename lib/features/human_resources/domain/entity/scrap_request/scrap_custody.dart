import 'package:equatable/equatable.dart';

class ScrapCustody extends Equatable {
  final int id;
  final String name;
  final int productId;
  final String productName;

  const ScrapCustody({
    required this.id,
    required this.name,
    required this.productId,
    required this.productName,
  });

  @override
  List<Object?> get props => [id, name, productId, productName];
}
