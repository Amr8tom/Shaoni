import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/utils/helpers/date_converter.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/generated/l10n.dart';
import 'package:shaoni/core/theme/theme.dart';

/// A stateless date-picker field.
///
/// Renders a tappable Gregorian text field that opens a [showDatePicker]
/// dialog, plus a read-only Hijri display row underneath.
///
/// The parent is responsible for holding the two [TextEditingController]s
/// and reacting to [onDateSelected] to update them (and any computed
/// duration, etc.).
class StudyDatePickerField extends StatelessWidget {
  const StudyDatePickerField({
    super.key,
    required this.label,
    required this.gregorianController,
    required this.hijriController,
    required this.onDateSelected,
  });

  final String label;
  final TextEditingController gregorianController;
  final TextEditingController hijriController;

  /// Called with the selected Gregorian string (`yyyy-MM-dd`)
  /// and the converted Hijri string.
  final void Function(String gregorian, String hijri) onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Gregorian date picker ─────────────────────────────────────────
        DEditableField(
          label: label,
          hint: 'YYYY-MM-DD',
          icon: Icons.calendar_today_rounded,
          iconColor: ColorRes.primary,
          controller: gregorianController,
          readOnly: true,
          onTap: () async {
            final initial = gregorianController.text.isNotEmpty
                ? DateTime.tryParse(gregorianController.text) ?? DateTime.now()
                : DateTime.now();

            final picked = await showDatePicker(
              context: context,
              initialDate: initial,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: DAppTheme.datePickerBuilder,
            );

            if (picked != null) {
              final gregorian =
                  '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
              final hijri = DateConverter.convertGregorianToHijri(gregorian);
              onDateSelected(gregorian, hijri);
            }
          },
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 6),

        // ── Hijri display (read-only) ─────────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.padding * 0.8,
            vertical: AppSizes.padding * 0.55,
          ),
          decoration: BoxDecoration(
            color: ColorRes.grey4,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
          child: Text(
            hijriController.text.isEmpty ? '––' : '${hijriController.text} هـ',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorRes.grey2,
                  fontSize: 11,
                ),
          ),
        ),
      ],
    );
  }
}
