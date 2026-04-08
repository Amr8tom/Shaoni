import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
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
    HijriCalendar _today = HijriCalendar.now();
    HijriCalendar.setLocal('ar');


    final hijriDate=DateConverter.convertGregorianToHijri(
      DateFormat('dd-MM-yyyy', 'ar').format(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      )).toString(),
    );
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
            /// birthDate time
            Flexible(
              child: AuthTextField(
                borderRadius: AppSizes.borderRadiusMd,
                hint: S.current.dateBirth,
                suffixIcon: Icon(
                  Icons.date_range,
                  color: ColorRes.grey2.withOpacity(0.5),
                ),
                controller: TextEditingController(
                  text: DateFormat('dd/MM/yyyy', S.current.localeee).format(DateTime.now()),
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
            /// hijriDate Time
            Flexible(
              child: AuthTextField(
                borderRadius: AppSizes.borderRadiusMd,
                hint: S.current.hijriDate,
                suffixIcon: Icon(
                  Icons.date_range,
                  color: ColorRes.grey2.withOpacity(0.5),
                ),
                controller: TextEditingController(
                  text:    _today.toFormat("yyyy/MMMM/dd",)
                  ,
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
