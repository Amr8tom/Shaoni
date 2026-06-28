import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/auth/presentation/widgets/auth_text_filed.dart';
import 'package:shaoni/generated/l10n.dart';

/// A tap-to-pick date field that mirrors the project's read-only text-field
/// style and reports the selected [DateTime] back to the caller.
class VisaDateField extends StatelessWidget {
  const VisaDateField({
    super.key,
    required this.label,
    required this.date,
    required this.onPicked,
    this.firstDate,
  });

  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onPicked;
  final DateTime? firstDate;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: date == null
          ? ''
          : DateFormat('dd/MM/yyyy', S.current.localeee).format(date!),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthTextField(
          label: label,
          hint: 'dd/MM/yyyy',
          controller: controller,
          readOnly: true,
          borderRadius: AppSizes.borderRadiusMd,
          suffixIcon: Icon(
            Icons.date_range,
            size: AppSizes.fontSizeMd,
            color: ColorRes.grey2.withValues(alpha: 0.5),
          ),
          validator: (value) =>
              (value?.isEmpty ?? true) ? S.current.pleaseEndterValue : null,
          onTap: () async {
            final now = DateTime.now();
            final picked = await showDatePicker(
              context: context,
              initialDate: date ?? now,
              firstDate: firstDate ?? DateTime(now.year - 1),
              lastDate: DateTime(now.year + 5),
            );
            if (picked != null) onPicked(picked);
          },
        ),
      ],
    );
  }
}
