import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/theme/theme.dart';
import 'package:shaoni/features/auth/presentation/widgets/auth_text_filed.dart';
import 'package:shaoni/generated/l10n.dart';

/// A tap-to-pick date field matching the project's read-only text-field style.
class LeaveDateField extends StatelessWidget {
  const LeaveDateField({
    super.key,
    required this.label,
    required this.date,
    required this.onPicked,
  });

  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onPicked;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: date == null ? '' : DateFormat('dd/MM/yyyy', 'en').format(date!),
    );

    return AuthTextField(
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
          firstDate: DateTime(now.year - 2),
          lastDate: DateTime(now.year + 5),
          // Note: do NOT wrap in Localizations.override(locale: 'en') — that
          // reloads S for 'en' and sets Intl.defaultLocale globally, flipping
          // the whole app to English. The field text is already English via
          // DateFormat('dd/MM/yyyy', 'en').
          builder: DAppTheme.datePickerBuilder,
        );
        if (picked != null) onPicked(picked);
      },
    );
  }
}
