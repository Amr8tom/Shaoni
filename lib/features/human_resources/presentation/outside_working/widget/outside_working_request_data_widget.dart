import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resources/presentation/controller/outside_working/outside_working_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

/// سبب الطلب + نوع القسم + نوع المشروع (+ اسم المشروع عند اختيار مشروع محدد)
class OutsideWorkingRequestDataWidget extends StatelessWidget {
  const OutsideWorkingRequestDataWidget({super.key});

  /// The lookups return the backend code in `nameEn` and the label in `nameAr`.
  String _label(String nameAr, String nameEn) => S.current.localeee == 'en'
      ? (nameEn.isEmpty ? nameAr : nameEn)
      : (nameAr.isEmpty ? nameEn : nameAr);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OutsideWorkingCubit>();

    return BlocBuilder<OutsideWorkingCubit, OutsideWorkingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// ── نوع القسم ───────────────────────────────────────────────────
            DDropdownField(
              label: S.current.departmentType,
              hint: S.current.selectDepartmentType,
              icon: Icons.business_rounded,
              value: state.departmentTypeCode,
              items: state.departmentTypes
                  .map((t) => DropdownMenuItem<String>(
                        value: t.nameEn,
                        child: Text(_label(t.nameAr, t.nameEn),
                            style: const TextStyle(fontSize: 12)),
                      ))
                  .toList(),
              onChanged: cubit.onDepartmentTypeSelected,
              validator: (v) =>
                  (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
            ),
            const Sizer(height: 20),

            /// ── نوع المشروع ─────────────────────────────────────────────────
            DDropdownField(
              label: S.current.projectType,
              hint: S.current.selectProjectType,
              icon: Icons.category_rounded,
              value: state.projectTypeCode,
              items: state.projectTypes
                  .map((t) => DropdownMenuItem<String>(
                        value: t.nameEn,
                        child: Text(_label(t.nameAr, t.nameEn),
                            style: const TextStyle(fontSize: 12)),
                      ))
                  .toList(),
              onChanged: cubit.onProjectTypeSelected,
              validator: (v) =>
                  (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
            ),

            /// ── اسم المشروع (only for a specific project type) ───────────────
            if (state.showProjectName) ...[
              const Sizer(height: 20),
              if (state.projectsLoading)
                const Center(child: CircularProgressIndicator())
              else
                DDropdownField(
                  label: S.current.projectName,
                  hint: S.current.selectProjectName,
                  icon: Icons.folder_rounded,
                  value: state.selectedProjectId?.toString(),
                  items: state.projects
                      .map((p) => DropdownMenuItem<String>(
                            value: p.id.toString(),
                            child: Text(p.name,
                                style: const TextStyle(fontSize: 12)),
                          ))
                      .toList(),
                  onChanged: cubit.onProjectNameSelected,
                  validator: (v) => (v == null || v.isEmpty)
                      ? S.current.thisFieldRequired
                      : null,
                ),
            ],

            const Sizer(height: 20),

            /// ── سبب الطلب ───────────────────────────────────────────────────
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
      },
    );
  }
}
