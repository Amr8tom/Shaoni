import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/helpers/arabic_to_english_number_formatter.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../controller/loan/loan_cubit.dart';
import '../../controller/loan/loan_state.dart';

class LoanRequestDataWidget extends StatelessWidget {
  const LoanRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanCubit, LoanState>(
      builder: (context, state) {
        final cubit = LoanCubit.get(context);
        final loanTypes = state is LoanLookupsLoaded ? state.loanTypes : [];

        return Container(
          padding: EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorRes.greyForBorders),
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Loan type dropdown ──
              Text(
                S.current.loanType,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorRes.grey3,
                    ),
              ),
              const Sizer(height: 8),
              DropdownButtonFormField<int>(
                value: cubit.selectedLoanTypeId,
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSizes.padding,
                    vertical: AppSizes.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSmall),
                    borderSide: BorderSide(color: ColorRes.greyForBorders),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSmall),
                    borderSide: BorderSide(color: ColorRes.greyForBorders),
                  ),
                ),
                hint: Text(
                  S.current.loanType,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                items: loanTypes
                    .map(
                      (t) => DropdownMenuItem<int>(
                        value: t.id,
                        child: Text(
                          t.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (id) {
                  if (id == null) return;
                  final type = loanTypes.firstWhere((t) => t.id == id);
                  cubit.selectLoanType(type);
                },
                validator: (v) =>
                    v == null ? S.current.thisFieldRequired : null,
              ),
              const Sizer(height: 16),

              // ── Amount ──
              Text(
                S.current.loanAmount,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorRes.grey3,
                    ),
              ),
              const Sizer(height: 8),
              TextFormField(
                controller: cubit.amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  ArabicToEnglishNumberFormatter(),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                decoration: InputDecoration(
                  hintText: S.current.loanAmount,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSizes.padding,
                    vertical: AppSizes.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSmall),
                    borderSide: BorderSide(color: ColorRes.greyForBorders),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSmall),
                    borderSide: BorderSide(color: ColorRes.greyForBorders),
                  ),
                ),
                validator: (v) => (v == null || v.isEmpty)
                    ? S.current.thisFieldRequired
                    : null,
              ),
              const Sizer(height: 16),

              // ── Payment period (months) ──
              Text(
                S.current.loanPaymentPeriod,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorRes.grey3,
                    ),
              ),
              const Sizer(height: 8),
              TextFormField(
                controller: cubit.paymentPeriodController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  ArabicToEnglishNumberFormatter(),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: S.current.loanPaymentPeriod,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSizes.padding,
                    vertical: AppSizes.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSmall),
                    borderSide: BorderSide(color: ColorRes.greyForBorders),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSmall),
                    borderSide: BorderSide(color: ColorRes.greyForBorders),
                  ),
                ),
                validator: (v) => (v == null || v.isEmpty)
                    ? S.current.thisFieldRequired
                    : null,
              ),
              const Sizer(height: 16),

              // ── First installment date ──
              Text(
                S.current.firstInstallmentDate,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorRes.grey3,
                    ),
              ),
              const Sizer(height: 8),
              TextFormField(
                controller: cubit.firstInstallmentDateController,
                readOnly: true,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.tryParse(
                          cubit.firstInstallmentDateController.text,
                        ) ??
                        DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                    builder: (
                      BuildContext context,
                      Widget? child,
                    ) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: ColorRes.primary,
                            onPrimary: ColorRes.white,
                            surface: ColorRes.white,
                            onSurface: ColorRes.black,
                          ),
                          textTheme: TextTheme(
                            titleLarge: TextStyle(
                              color: ColorRes.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 6,
                            ),
                          ),
                          dialogTheme: DialogTheme(
                            backgroundColor: ColorRes.white,
                            titleTextStyle: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(
                                  color: ColorRes.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 6,
                                ),
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: ColorRes.primary,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    cubit.firstInstallmentDateController.text =
                        picked.toIso8601String().substring(0, 10);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'YYYY-MM-DD',
                  suffixIcon: const Icon(Icons.calendar_today_outlined),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSizes.padding,
                    vertical: AppSizes.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSmall),
                    borderSide: BorderSide(color: ColorRes.greyForBorders),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSmall),
                    borderSide: BorderSide(color: ColorRes.greyForBorders),
                  ),
                ),
                validator: (v) => (v == null || v.isEmpty)
                    ? S.current.thisFieldRequired
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
