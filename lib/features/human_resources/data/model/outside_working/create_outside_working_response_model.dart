import 'package:shaoni/features/human_resources/domain/entity/outside_working/create_outside_working_response.dart';

class CreateOutsideWorkingResponseModel extends CreateOutsideWorkingResponse {
  const CreateOutsideWorkingResponseModel({
    required super.odooOutsideWorkingId,
    required super.outsideWorkingName,
  });

  factory CreateOutsideWorkingResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CreateOutsideWorkingResponseModel(
        odooOutsideWorkingId:
            (json['odooOutsideWorkingId'] as num?)?.toInt() ?? 0,
        outsideWorkingName: json['outsideWorkingName'] as String? ?? '',
      );
}
