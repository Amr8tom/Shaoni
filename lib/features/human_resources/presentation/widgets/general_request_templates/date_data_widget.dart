import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/auth_text_filed.dart';

class DateDataWidget extends StatelessWidget {
  const DateDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar today = HijriCalendar.now();
    HijriCalendar.setLocal('ar');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// dates titles and text fields
        Text(
          S.current.date,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
const Sizer(height: 8,),
        /// date
        Row(
          spacing: 8,
          children: [
            /// birthDate time
            Flexible(
              child: AuthTextField(
                borderRadius: AppSizes.borderRadiusMd,
                hint: S.current.dateBirth,
                suffixIcon: Icon(
                  Icons.date_range,
                  size: AppSizes.fontSizeMd,
                  color: ColorRes.grey2.withValues(alpha: 0.5),
                ),
                controller: TextEditingController(
                  text: DateFormat('dd/MM/yyyy', S.current.localeee)
                      .format(DateTime.now()),
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
                  size: AppSizes.fontSizeMd,
                  color: ColorRes.grey2.withValues(alpha: 0.5),
                ),
                controller: TextEditingController(
                  text: today.toFormat("yyyy/MMMM/dd"),
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
