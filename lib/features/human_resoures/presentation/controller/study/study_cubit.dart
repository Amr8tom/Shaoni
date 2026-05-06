import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/enums/general_status.dart';

part 'study_state.dart';

class StudyCubit extends Cubit<StudyState> {
  final requestFormKey = GlobalKey<FormState>();
  final TextEditingController todayDateController = TextEditingController();

  /// Gregorian date the user picks via the date picker (`yyyy-MM-dd`).
  final attendanceDateController = TextEditingController();

  /// ================== applicant and data controllers ==================
  final attendanceTimeController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();

  /// ======================================================
  final DurationTimeByMonthsController = TextEditingController();
  final DurationTimeByDaysController = TextEditingController();
  final courseStartTimeController = TextEditingController();
  final courseEndTimeController = TextEditingController();
  final nominationStartTimeController = TextEditingController();
  final nominationEndTimeController = TextEditingController();


  final orderReasonController = TextEditingController();

  List<DropdownMenuItem<String>> studyTypeItems = [];

  StudyCubit() : super(const StudyState()) {}

  /// create study request
  Future<void> createStudyRequest() async {

  }


  /// delete
  void deleteStudyRequest() {
    todayDateController.clear();
    attendanceDateController.clear();
    attendanceTimeController.clear();
    applicantNameController.clear();
    organizationalUnitController.clear();
    attachmentFileController.clear();
    attachmentFileNameController.clear();
    DurationTimeByMonthsController.clear();
    DurationTimeByDaysController.clear();
    courseStartTimeController.clear();
    courseEndTimeController.clear();
    nominationStartTimeController.clear();
    nominationEndTimeController.clear();
    orderReasonController.clear();

  }

  /// destroy controllers
  @override
  Future<void> close() {
    todayDateController.dispose();
    attendanceDateController.dispose();
    attendanceTimeController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    DurationTimeByMonthsController.dispose();
    DurationTimeByDaysController.dispose();
    courseStartTimeController.dispose();
    courseEndTimeController.dispose();
    nominationStartTimeController.dispose();
    nominationEndTimeController.dispose();
    orderReasonController.dispose();

    return super.close();
  }
}
