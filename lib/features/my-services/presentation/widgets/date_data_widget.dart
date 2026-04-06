import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/helpers/date_converter.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentation/widgets/auth_text_filed.dart';
import '../controller/request_services/request_service_cubit.dart';

class DateDataWidget extends StatelessWidget {
  const DateDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// dates titles and text fields
        Text(
          S.current.date,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        /// date
        Row(
          spacing: 10,
          children: [
            Flexible(
              child: AuthTextField(
                borderRadius: AppSizes.borderRadiusMd,
                hint: S.current.dateBirth,
                suffixIcon: Icon(
                  Icons.date_range,
                  color: ColorRes.grey2.withOpacity(0.5),
                ),
                controller: TextEditingController(
                  text: DateFormat('dd/MM/yyyy', 'en_US').format(DateTime.now()),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.pleaseEndterValue;
                  }
                  return null;
                },
              ),
            ),
            Flexible(
              child: AuthTextField(
                borderRadius: AppSizes.borderRadiusMd,
                hint: S.current.hijriDate,
                suffixIcon: Icon(
                  Icons.date_range,
                  color: ColorRes.grey2.withOpacity(0.5),
                ),
                controller: TextEditingController(
                  text: DateConverter.convertGregorianToHijriFormatted(
                    DateFormat('dd/MM/yyyy', 'en_Us').format(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                    )).toString(),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.pleaseEndterValue;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
