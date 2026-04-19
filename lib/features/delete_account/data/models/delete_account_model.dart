import '../../domain/entities/delete_account.dart';

class DeleteAccountModel extends DeleteAccount{
   DeleteAccountModel();
  /// from json
  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) {
    return DeleteAccountModel();
  }
  /// to json

}