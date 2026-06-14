import 'package:equatable/equatable.dart';

class LoanType extends Equatable {
  final int id;
  final String name;
  final bool needEmp;

  const LoanType({
    required this.id,
    required this.name,
    required this.needEmp,
  });

  @override
  List<Object?> get props => [id, name, needEmp];
}
