
import 'package:shaoni/features/human_resources/domain/entity/attendance/forget_reason.dart';

class ForgetReasonModel extends ForgetReason{
const ForgetReasonModel({required super.id, required super.name, required super.nameEn});
/// from json
factory ForgetReasonModel.fromJson(Map<String, dynamic> json) {
  return ForgetReasonModel(
    id: json['id'],
    name: json['name'],
    nameEn: json['nameEn'],
  );}
  /// to json
 Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'nameEn': this.nameEn,
    };
  }
}