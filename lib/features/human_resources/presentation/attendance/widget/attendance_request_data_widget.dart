import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../domain/entity/attendance_record.dart';
import '../../controller/attendance/attendance_cubit.dart';
import 'attendance_dropdown_field.dart';
import 'attendance_editable_field.dart';
import 'attendance_info_tile.dart';


class AttendanceRequestDataWidget extends StatelessWidget {
  const AttendanceRequestDataWidget({
    super.key,
    this.record,
  });
  final AttendanceRecord? record;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AttendanceCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// ─── Section 1: Read-only API data ───────────────────────────
        _buildReadOnlySection(context),

        const Sizer(height: 24),

        /// ─── Section 2: User input ───────────────────────────────────
        _buildUserInputSection(context, controller),
      ],
    );
  }

  // -------------------------------------------------------------------
  // Read-only data tiles populated from `record` (API response).
  // -------------------------------------------------------------------
  Widget _buildReadOnlySection(BuildContext context) {

    const String empty = '00:00';

    final String fingerprint = record?.displayName ?? empty;
    final String checkInFromRecord = record?.checkInTime ?? empty;
    final String checkOutFromRecord = record?.checkOutTime ?? empty;
    final String inMode = record?.inMode ?? S.current.notAvailable;
    final String outMode = record?.outMode ?? S.current.notAvailable;

    const String overtime = empty;
    const String workedHours = empty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Row: overtime  |  check-in (from record)
        _PairRow(
          right: AttendanceInfoTile(
            label: S.current.checkInFromRecord,
            value: checkInFromRecord,
            icon: Icons.access_time_rounded
          ),
          left: AttendanceInfoTile(
            label: S.current.overtime,
            value: overtime,
            icon: Icons.access_time_rounded,
          ),
        ),
        const Sizer(height: 14),

        /// Row: fingerprint record (displayName)  |  check-in mode
        _PairRow(
          right: AttendanceInfoTile(
            label: S.current.checkInMode,
            value: inMode,
            icon: Icons.fingerprint_rounded,
            iconColor: ColorRes.primary,
          ),
          left: AttendanceInfoTile(
            label: S.current.fingerprintRecord,
            value: fingerprint,
            icon: Icons.fingerprint_rounded,
          ),
        ),
        const Sizer(height: 14),

        /// Row: check-out mode  |  check-out (from record)
        _PairRow(
          right: AttendanceInfoTile(
            label: S.current.checkOutFromRecord,
            value: checkOutFromRecord,
            icon: Icons.access_time_rounded,
          ),
          left: AttendanceInfoTile(
            label: S.current.checkOutMode,
            value: outMode,
            icon: Icons.fingerprint_rounded,
          ),
        ),
        const Sizer(height: 14),

        /// Full-width worked-hours tile
        AttendanceInfoTile(
          label: S.current.hoursWorked,
          value: workedHours,
          icon: Icons.access_time_rounded,
        ),
      ],
    );
  }

  // -------------------------------------------------------------------
  // User-input section — date / time / duration / type / forget reason.
  // -------------------------------------------------------------------
  Widget _buildUserInputSection(
    BuildContext context,
    AttendanceCubit controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Row: date  |  time (HH:mm)
        _PairRow(
          right: DEditableField(
            label: S.current.dateBirth,
            hint: S.current.selectDate,
            icon: Icons.calendar_today_rounded,
            controller: controller.attendanceDateController,
            onTap: () => _pickDate(context, controller),
            validator: _requiredValidator,
          ),
          left: DEditableField(
            label: S.current.timeOfDay,
            hint: S.current.selectTime,
            icon: Icons.access_time_rounded,
            controller: controller.attendanceTimeController,
            onTap: () => _pickTime(context, controller),
            validator: _requiredValidator,
          ),
        ),
        const Sizer(height: 14),

        /// Row: duration (hours)  |  attendance type
        DDropdownField(
          label: S.current.attendanceType,
          hint: S.current.attendanceType,
          icon: Icons.list_alt_rounded,
          items: controller.attendanceTypeItems,
          value: controller.attendanceTypeController.text.isEmpty
              ? null
              : controller.attendanceTypeController.text,
          onChanged: (value) {
            controller.attendanceTypeController.text = value ?? '';
          },
          validator: _requiredValidator,
        ),
        const Sizer(height: 14),

        /// Full-width: forget reason
        DDropdownField(
          label: S.current.forgetReason,
          hint: S.current.forgetReason,
          icon: Icons.help_outline_rounded,
          items: controller.forgetReasonItems,
          value: controller.forgetReasonController.text.isEmpty
              ? null
              : controller.forgetReasonController.text,
          onChanged: (value) {
            controller.forgetReasonController.text = value ?? '';
          },
          validator: _requiredValidator,
        ),
      ],
    );
  }

  // -------------------------------------------------------------------
  // Pickers + validators
  // -------------------------------------------------------------------

  Future<void> _pickDate(
    BuildContext context,
    AttendanceCubit controller,
  ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      helpText: S.current.selectDate,
      cancelText: S.current.cancel,
      confirmText: S.current.done,
      builder: _pickerTheme,
    );
    if (pickedDate != null) {
      controller.attendanceDateController.text =
          DateFormat('yyyy-MM-dd', 'en_US').format(pickedDate);
    }
  }

  Future<void> _pickTime(
    BuildContext context,
    AttendanceCubit controller,
  ) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: S.current.selectTime,
      cancelText: S.current.cancel,
      confirmText: S.current.done,
      builder: _pickerTheme,
    );
    if (pickedTime != null) {
      /// Format as `HH:mm` (24-hour), independent of locale.
      final hour = pickedTime.hour.toString().padLeft(2, '0');
      final minute = pickedTime.minute.toString().padLeft(2, '0');
      controller.attendanceTimeController.text = '$hour:$minute';
    }
  }

  /// Shared light theme used by both pickers so they match the app palette.
  Widget _pickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: ColorRes.primary,
          onPrimary: ColorRes.white,
          surface: ColorRes.white,
          onSurface: ColorRes.black,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: ColorRes.black,
            fontWeight: FontWeight.bold,
            fontSize: 6,
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: ColorRes.white,
          titleTextStyle: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(
            color: ColorRes.black,
            fontWeight: FontWeight.bold,
            fontSize: 6,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: ColorRes.primary,
          ),
        ),
      ),
      child: child!,
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEndterValue;
    }
    return null;
  }
}

/// Helper that pairs two fields (right + left) in a row with a 14px gap
/// and equal flex — mirrors the screenshot's "two-up" layout for RTL.
class _PairRow extends StatelessWidget {
  const _PairRow({required this.right, required this.left});

  final Widget right;
  final Widget left;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: right),
          const Sizer(width: 14),
          Expanded(child: left),
        ],
      ),
    );
  }
}
