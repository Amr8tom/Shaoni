import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resources/presentation/controller/medical_insurance/medical_insurance_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

class MedicalInsuranceDataWidget extends StatelessWidget {
  const MedicalInsuranceDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MedicalInsuranceCubit>();
    final state = controller.state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Dropdown: insurance class ────────────────────────────────────
        DDropdownField(
          label: S.current.insuranceClass,
          hint: S.current.selectInsuranceClass,
          icon: Icons.health_and_safety_rounded,
          items: controller.insuranceClassItems,
          value: controller.insuranceClassController.text.isEmpty
              ? null
              : controller.insuranceClassController.text,
          onChanged: (value) {
            controller.insuranceClassController.text = value ?? '';
          },
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── Radio: include family member ─────────────────────────────────
        Text(
          S.current.includeFamilyMembers,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorRes.black,
              ),
        ),
        const Sizer(height: 8),
        Row(
          children: [
            Expanded(
              child: _RadioOption(
                label: S.current.yes,
                value: true,
                groupValue: state.includeFamilyMember,
                onChanged: controller.setIncludeFamilyMember,
              ),
            ),
            const Sizer(width: 12),
            Expanded(
              child: _RadioOption(
                label: S.current.no,
                value: false,
                groupValue: state.includeFamilyMember,
                onChanged: controller.setIncludeFamilyMember,
              ),
            ),
          ],
        ),

        // ── Multi-select: family members (shown only when included) ──────
        if (state.includeFamilyMember) ...[
          const Sizer(height: 20),
          Text(
            S.current.familyMembers,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorRes.black,
                ),
          ),
          const Sizer(height: 8),
          if (controller.employeeRelatives.isEmpty)
            Text(
              S.current.noFamilyMembersFound,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: ColorRes.grey2),
            )
          else
            ...controller.employeeRelatives.map((relative) {
              final selected = controller.isRelativeSelected(relative.id);
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => controller.toggleRelative(relative.id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: selected
                          ? ColorRes.primary.withOpacity(0.08)
                          : ColorRes.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected ? ColorRes.primary : ColorRes.grey4,
                        width: selected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.check_box_rounded
                              : Icons.check_box_outline_blank_rounded,
                          color:
                              selected ? ColorRes.primary : ColorRes.grey3,
                          size: 20,
                        ),
                        const Sizer(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.localizedRelativeName(relative),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                controller.localizedRelationName(relative),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: ColorRes.grey2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        ],

        const Sizer(height: 20),

        // ── Text area: reason for upgrade ────────────────────────────────
        DEditableField(
          label: S.current.reasonForUpgrade,
          hint: S.current.reasonForUpgradeHint,
          icon: Icons.notes_rounded,
          iconColor: ColorRes.black,
          controller: controller.reasonForUpgradeController,
          readOnly: false,
          keyboardType: TextInputType.multiline,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── Text area: note (optional) ───────────────────────────────────
        DEditableField(
          label: S.current.notes,
          hint: S.current.notesHint,
          icon: Icons.sticky_note_2_outlined,
          iconColor: ColorRes.black,
          controller: controller.noteController,
          readOnly: false,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}

class _RadioOption extends StatelessWidget {
  const _RadioOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final bool groupValue;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? ColorRes.primary.withOpacity(0.08) : ColorRes.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? ColorRes.primary : ColorRes.grey4,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? ColorRes.primary : ColorRes.grey3,
              size: 20,
            ),
            const Sizer(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: selected ? ColorRes.primary : ColorRes.black,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
