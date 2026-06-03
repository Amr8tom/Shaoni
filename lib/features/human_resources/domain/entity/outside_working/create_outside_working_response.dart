import 'package:equatable/equatable.dart';

class CreateOutsideWorkingResponse extends Equatable {
  final int odooOutsideWorkingId;
  final String outsideWorkingName;

  const CreateOutsideWorkingResponse({
    required this.odooOutsideWorkingId,
    required this.outsideWorkingName,
  });

  @override
  List<Object?> get props => [odooOutsideWorkingId, outsideWorkingName];
}
