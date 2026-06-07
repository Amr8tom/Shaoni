import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resources/presentation/controller/outside_working/outside_working_cubit.dart';
import 'package:shaoni/generated/l10n.dart';


class OutsideWorkingRequestDataWidget extends StatelessWidget {
  const OutsideWorkingRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OutsideWorkingCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// ──  department ─────────────────────────────────────────────────────
        DDropdownField(
          label: S.current.departmentType,
          hint: S.current.selectDepartmentType,
          icon: Icons.business_rounded,
          items: cubit.departmentTypeItems,
          value: cubit.departmentTypeController.text.isEmpty
              ? null
              : cubit.departmentTypeController.text,
          onChanged: cubit.onDepartmentTypeSelected,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        /// ── project type ───────────────────────────────────────────────────
        DDropdownField(
          label: S.current.projectType,
          hint: S.current.selectProjectType,
          icon: Icons.category_rounded,
          items: cubit.projectTypeItems,
          value: cubit.projectTypeController.text.isEmpty
              ? null
              : cubit.projectTypeController.text,
          onChanged: cubit.onProjectTypeSelected,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),

        /// project name (conditional) ─────────────────────────────────────
        if (cubit.showProjectName) ...[
          const Sizer(height: 20),
          DDropdownField(
            label: S.current.projectName,
            hint: S.current.selectProjectName,
            icon: Icons.folder_rounded,
            items: cubit.projectNameItems,
            value: cubit
                .selectedProjectId, // ID string; items also have id as value
            onChanged: cubit.onProjectNameSelected,
            validator: (v) =>
                (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
          ),
        ],

        const Sizer(height: 20),

        /// ── request reason  ─────────────────────────────────────────────────────
        DEditableField(
          label: S.current.orderReason,
          hint: S.current.orderReason,
          icon: Icons.notes_rounded,
          controller: cubit.orderReasonController,
          readOnly: false,
          keyboardType: TextInputType.multiline,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
      ],
    );
  }
}
