import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/auth/presentation/widgets/auth_text_filed.dart';
import 'package:shaoni/features/booking_managment/presentation/controller/visa_request/visa_request_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

class VisaDataWidget extends StatelessWidget {
  const VisaDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<VisaRequestCubit>();

    return BlocBuilder<VisaRequestCubit, VisaRequestState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.visaData,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Sizer(height: 16),

            /// Visa type
            _VisaLabeledDropdown<int>(
              label: S.current.visaType,
              hint: S.current.selectVisaType,
              value: state.selectedVisaTypeId,
              items: state.visaTypes
                  .map((t) => DropdownMenuItem<int>(
                        value: t.id,
                        child: Text(
                          S.current.localeee == 'en' ? t.nameEn : t.nameAr,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              validator: (value) =>
                  value == null ? S.current.pleaseEndterValue : null,
              onChanged: (id) {
                if (id == null) return;
                final type = state.visaTypes.firstWhere((t) => t.id == id);
                controller.selectVisaType(type);
              },
            ),
            const Sizer(height: 16),

            /// Language
            _VisaLabeledDropdown<int>(
              label: S.current.language,
              hint: S.current.selectLanguage,
              value: state.selectedLangId,
              items: state.languages
                  .map((l) => DropdownMenuItem<int>(
                        value: l.id,
                        child: Text(
                          l.name,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              validator: (value) =>
                  value == null ? S.current.pleaseEndterValue : null,
              onChanged: (id) {
                if (id == null) return;
                final language = state.languages.firstWhere((l) => l.id == id);
                controller.selectLanguage(language);
              },
            ),
            const Sizer(height: 16),

            /// Direction / destination
            AuthTextField(
              label: S.current.visaDirection,
              hint: S.current.visaDirectionHint,
              controller: controller.directionController,
              borderRadius: AppSizes.borderRadiusMd,
              validator: (value) =>
                  (value?.isEmpty ?? true) ? S.current.pleaseEndterValue : null,
            ),
            const Sizer(height: 16),

            /// Reason
            AuthTextField(
              label: S.current.requestReason,
              hint: S.current.visaReasonHint,
              controller: controller.reasonController,
              borderRadius: AppSizes.borderRadiusMd,
              validator: (value) =>
                  (value?.isEmpty ?? true) ? S.current.pleaseEndterValue : null,
            ),
            const Sizer(height: 16),

            /// Note (optional)
            AuthTextField(
              label: S.current.notes,
              hint: S.current.visaNotesHint,
              controller: controller.noteController,
              borderRadius: AppSizes.borderRadiusMd,
            ),
          ],
        );
      },
    );
  }
}

// ── Labeled dropdown ──────────────────────────────────────────────────────────

class _VisaLabeledDropdown<T> extends StatelessWidget {
  const _VisaLabeledDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final String label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const Sizer(height: 6),
        DropdownButtonFormField<T>(
          hint: Text(hint, style: const TextStyle(fontSize: 12)),
          value: value,
          isExpanded: true,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding * 0.75,
              vertical: AppSizes.padding * 0.5,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.greyForBorders),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.greyForBorders),
            ),
            filled: true,
            fillColor: ColorRes.white,
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
