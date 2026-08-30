import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../core/constants/colors.dart';
import '../../attendance/widget/attendance_dropdown_field.dart';
import '../../attendance/widget/attendance_editable_field.dart';
import '../../controller/car_permission/car_permission_cubit.dart';

/// "بيانات الطلب" section of the car-permission request screen.
///
/// Three fields — car brand (lookup dropdown), car color (lookup
/// dropdown), and car plate number (free text). Reuses the modern form
/// atoms originally built for the attendance request form so the visual
/// language stays consistent across HR services.
class CarRequestDataWidget extends StatelessWidget {
  const CarRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CarPermissionCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// ─── Row: car brand  |  car color ───────────────────────────
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DDropdownField(
                  label: S.current.carBrand,
                  hint: S.current.selectCarBrand,
                  icon: Icons.directions_car_rounded,
                  items: controller.carBrandItems,
                  value: controller.carBrandController.text.isEmpty
                      ? null
                      : controller.carBrandController.text,
                  onChanged: (value) {
                    controller.carBrandController.text = value ?? '';
                  },
                  validator: _requiredValidator,
                ),
              ),
              const Sizer(width: 14),
              Expanded(
                child: DDropdownField(
                  label: S.current.carColor,
                  hint: S.current.selectCarColor,
                  icon: Icons.color_lens_rounded,
                  items: controller.carColorItems,
                  value: controller.carColorController.text.isEmpty
                      ? null
                      : controller.carColorController.text,
                  onChanged: (value) {
                    controller.carColorController.text = value ?? '';
                  },
                  validator: _requiredValidator,
                ),
              ),
            ],
          ),
        ),
        const Sizer(height: 14),

        /// ─── Full-width: car plate number ────────────────────────────
        DEditableField(
          label: S.current.carNumber,
          hint: S.current.carNumberHint,
          icon: Icons.confirmation_number_rounded,
          iconColor: ColorRes.black,
          controller: controller.carNumberController,
          readOnly: false,
          keyboardType: TextInputType.text,
          validator: _requiredValidator,
        ),
        const Sizer(height: 14),

        /// ─── Full-width: notes (optional) ────────────────────────────
        DEditableField(
          label: S.current.notes,
          hint: S.current.notesHint,
          icon: Icons.sticky_note_2_outlined,
          iconColor: ColorRes.black,
          controller: controller.notesController,
          readOnly: false,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEndterValue;
    }
    return null;
  }
}
