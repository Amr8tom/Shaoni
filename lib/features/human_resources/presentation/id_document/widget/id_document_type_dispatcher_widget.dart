import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/human_resources/presentation/controller/id_document/id_document_cubit.dart';
import 'driving_license_data_widget.dart';
import 'family_card_data_widget.dart';
import 'national_id_data_widget.dart';
import 'passport_data_widget.dart';
import 'residency_data_widget.dart';

/// Dispatches to the correct document data widget based on the selected
/// document type code stored in [IDDocumentCubit.documentTypeController].
class IDDocumentTypeDispatcherWidget extends StatelessWidget {
  const IDDocumentTypeDispatcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<IDDocumentCubit>();
    final code = cubit.documentTypeController.text;

    switch (code) {
      case 'national_id':
        return const NationalIdDataWidget();
      case 'residency':
        return const ResidencyDataWidget();
      case 'passport':
        return const PassportDataWidget();
      case 'family_card':
        return const FamilyCardDataWidget();
      case 'driving_license':
        return const DrivingLicenseDataWidget();
      default:
        // Nothing shown until user selects a document type
        return const SizedBox.shrink();
    }
  }
}
