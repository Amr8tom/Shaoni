import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resoures/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/id_document/id_document_cubit.dart';
import 'package:shaoni/features/human_resoures/presentation/id_document/widget/id_document_base_fields_widget.dart';
import 'package:shaoni/generated/l10n.dart';

/// جواز سفر — base fields + passport number + passport address.
class PassportDataWidget extends StatelessWidget {
  const PassportDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<IDDocumentCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const IDDocumentBaseFieldsWidget(),
        const Sizer(height: 20),

        // ── رقم جواز السفر ────────────────────────────────────────────────
        DEditableField(
          label: S.current.passportNumber,
          hint: S.current.passportNumber,
          icon: Icons.book_rounded,
          iconColor: ColorRes.black,
          controller: cubit.passportNumberController,
          readOnly: false,
          keyboardType: TextInputType.text,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── عنوان جواز السفر ──────────────────────────────────────────────
        DEditableField(
          label: S.current.passportAddress,
          hint: S.current.passportAddress,
          icon: Icons.location_on_rounded,
          iconColor: ColorRes.black,
          controller: cubit.passportAddressController,
          readOnly: false,
          keyboardType: TextInputType.text,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
      ],
    );
  }
}
