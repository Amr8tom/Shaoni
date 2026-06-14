import 'package:equatable/equatable.dart';

class LoanInstallment extends Equatable {
  final int? id;
  final String? name;
  final String? installmentDate;
  final String? hijriDate;
  final double? installmentAmount;
  final String? status;

  const LoanInstallment({
    this.id,
    this.name,
    this.installmentDate,
    this.hijriDate,
    this.installmentAmount,
    this.status,
  });

  @override
  List<Object?> get props =>
      [id, name, installmentDate, hijriDate, installmentAmount, status];
}
