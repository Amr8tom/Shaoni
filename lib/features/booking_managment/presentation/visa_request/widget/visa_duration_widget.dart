import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/features/booking_managment/presentation/controller/visa_request/visa_request_cubit.dart';
import 'package:shaoni/features/booking_managment/presentation/visa_request/widget/visa_date_field.dart';
import 'package:shaoni/features/human_resources/presentation/widgets/general_request_templates/file_upload_widget.dart';
import 'package:shaoni/generated/l10n.dart';

class VisaDurationWidget extends StatelessWidget {
  const VisaDurationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<VisaRequestCubit>();

    return BlocBuilder<VisaRequestCubit, VisaRequestState>(
      buildWhen: (previous, current) =>
          previous.dateFrom != current.dateFrom ||
          previous.dateTo != current.dateTo,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.duration,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Sizer(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: VisaDateField(
                    label: S.current.startDate,
                    date: state.dateFrom,
                    onPicked: controller.setDateFrom,
                  ),
                ),
                const Sizer(width: 12),
                Expanded(
                  child: VisaDateField(
                    label: S.current.endDate,
                    date: state.dateTo,
                    firstDate: state.dateFrom,
                    onPicked: controller.setDateTo,
                  ),
                ),
              ],
            ),
            const Sizer(height: 16),

            /// Optional attachment
            FileUploadWidget(
              title: S.current.attachments,
              onPickedFile: controller.setAttachment,
            ),
          ],
        );
      },
    );
  }
}
