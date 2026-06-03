import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resources/presentation/controller/id_document/id_document_cubit.dart';
import 'package:shaoni/features/human_resources/presentation/id_document/widget/id_document_base_fields_widget.dart';
import 'package:shaoni/generated/l10n.dart';

/// بطاقة عائلية — base fields + family card number.
class FamilyCardDataWidget extends StatelessWidget {
  const FamilyCardDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<IDDocumentCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const IDDocumentBaseFieldsWidget(),
        const Sizer(height: 20),

        // ── رقم بطاقة عائلية ──────────────────────────────────────────────
        DEditableField(
          label: S.current.familyCardNumber,
          hint: S.current.familyCardNumber,
          icon: Icons.family_restroom_rounded,
          iconColor: ColorRes.black,
          controller: cubit.familyCardNumberController,
          readOnly: false,
          keyboardType: TextInputType.text,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
      ],
    );
  }
}
