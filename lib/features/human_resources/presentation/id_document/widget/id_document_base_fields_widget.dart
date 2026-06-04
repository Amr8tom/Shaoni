import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resources/presentation/controller/id_document/id_document_cubit.dart';
import 'package:shaoni/generated/l10n.dart';
import 'package:shaoni/core/constants/colors.dart';

class IDDocumentBaseFieldsWidget extends StatelessWidget {
  const IDDocumentBaseFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<IDDocumentCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── دولة الإصدار ──────────────────────────────────────────────────
        DDropdownField(
          label: S.current.issuingCountry,
          hint: S.current.selectIssuingCountry,
          icon: Icons.flag_rounded,
          items: cubit.issuingCountryItems,
          value: cubit.issuingCountryController.text.isEmpty
              ? null
              : cubit.issuingCountryController.text,
          onChanged: cubit.onCountrySelected,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── رقم المستند ───────────────────────────────────────────────────
        DEditableField(
          label: S.current.documentNumber,
          hint: S.current.documentNumber,
          icon: Icons.badge_rounded,
          iconColor: ColorRes.black,
          controller: cubit.documentNumberController,
          readOnly: false,
          keyboardType: TextInputType.text,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── رقم الإصدار ───────────────────────────────────────────────────
        DEditableField(
          label: S.current.issueNumber,
          hint: S.current.issueNumber,
          icon: Icons.numbers_rounded,
          iconColor: ColorRes.black,
          controller: cubit.issueNumberController,
          readOnly: false,
          keyboardType: TextInputType.text,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── تاريخ الإصدار م ───────────────────────────────────────────────
        DEditableField(
          label: S.current.issueDate,
          hint: S.current.issueDate,
          icon: Icons.calendar_today_rounded,
          iconColor: ColorRes.black,
          controller: cubit.issueDateController,
          readOnly: true,
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              builder: (
                BuildContext context,
                Widget? child,
              ) {
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
              },
            );
            if (picked != null) {
              cubit.issueDateController.text =
                  DateFormat('yyyy-MM-dd', 'en').format(picked);
            }
          },
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── النهاية م ─────────────────────────────────────────────────────
        DEditableField(
          label: S.current.endDate,
          hint: S.current.endDate,
          icon: Icons.calendar_month_rounded,
          iconColor: ColorRes.black,
          controller: cubit.endDateController,
          readOnly: true,
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              builder: (
                BuildContext context,
                Widget? child,
              ) {
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
              },
            );
            if (picked != null) {
              cubit.endDateController.text =
                  DateFormat('yyyy-MM-dd', 'en').format(picked);
            }
          },
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 12),

        // ── طبق checkbox ──────────────────────────────────────────────────
        CheckboxListTile(
          value: cubit.tabaq,
          onChanged: (val) => cubit.toggleTabaq(val ?? false),
          title: Text(
            S.current.tabaq,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          activeColor: ColorRes.primary,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
        ),

        // ── هل علي كفالة checkbox ──────────────────────────────────────────
        CheckboxListTile(
          value: cubit.kafala,
          onChanged: (val) => cubit.toggleKafala(val ?? false),
          title: Text(
            S.current.hasKafala,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          activeColor: ColorRes.primary,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
        ),

        // ── اسم الكفيل (conditional) ──────────────────────────────────────
        if (cubit.kafala) ...[
          const Sizer(height: 12),
          DEditableField(
            label: S.current.kafeelName,
            hint: S.current.kafeelName,
            icon: Icons.person_rounded,
            iconColor: ColorRes.black,
            controller: cubit.kafeelNameController,
            readOnly: false,
            keyboardType: TextInputType.text,
            validator: (v) =>
                (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
          ),
        ],
      ],
    );
  }
}
