import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/utils/enums/general_status.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceState());

  final TextEditingController todayDateController = TextEditingController();
  final TextEditingController permissionDateController =
      TextEditingController();
  final TextEditingController applicantNameController = TextEditingController();
  final TextEditingController organizationalUnitController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController hijriDateController = TextEditingController();
  final TextEditingController attachmentFileController =
      TextEditingController();
  final TextEditingController attachmentFileNameController =
      TextEditingController();

  /// delete all controllers
  void deleteControllers() {
    todayDateController.dispose();
    permissionDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    locationController.dispose();
    hijriDateController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
  }
  /// dispose all controllers
  @override
  Future<void> close() {
    deleteControllers();
    todayDateController.dispose();
    permissionDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    locationController.dispose();
    hijriDateController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
}
}
