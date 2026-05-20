import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/features/human_resoures/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/id_document/id_document_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

/// بيانات الطلب — request type + document type dropdowns.
/// The document type value is stored as a CODE so the dispatcher can switch on it.
class IDDocumentRequestDataWidget extends StatelessWidget {
  const IDDocumentRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<IDDocumentCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── نوع الطلب ─────────────────────────────────────────────────────
        DDropdownField(
          label: S.current.requestType,
          hint: S.current.selectRequestType,
          icon: Icons.assignment_rounded,
          items: cubit.requestTypeItems,
          value: cubit.requestTypeController.text.isEmpty
              ? null
              : cubit.requestTypeController.text,
          onChanged: (value) {
            cubit.requestTypeController.text = value ?? '';
            // Clear document type selection when request type changes
            cubit.documentTypeController.clear();
            cubit.notifyDropdownChanged();
          },
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── النوع (document type) ─────────────────────────────────────────
        // Value stored is the CODE (e.g. 'national_id'), not the display name.
        DDropdownField(
          label: S.current.documentType,
          hint: S.current.selectDocumentType,
          icon: Icons.credit_card_rounded,
          items: cubit.documentTypeItems,
          value: cubit.documentTypeController.text.isEmpty
              ? null
              : cubit.documentTypeController.text,
          onChanged: (value) {
            cubit.documentTypeController.text = value ?? '';
            cubit.notifyDropdownChanged();
          },
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
      ],
    );
  }
}
