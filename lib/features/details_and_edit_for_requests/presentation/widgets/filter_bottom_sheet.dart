import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/details_and_edit_for_requests/presentation/controller/my_requests_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MyRequestsCubit>();
    final services = cubit.availableServiceTypes;
    final selectedService = cubit.state.selectedServiceCode;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.padding,
        vertical: AppSizes.padding * 1.5,
      ),
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.borderRadiusLg),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.selectCategory,
                // Using selectCategory for filter header
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorRes.primary,
                    ),
              ),
              if (selectedService != null)
                TextButton(
                  onPressed: () {
                    cubit.clearFilter();
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.current.cancel, // or a "Clear" label if added to arb
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: ColorRes.primary,
                        ),
                  ),
                ),
            ],
          ),
          const Sizer(height: 16),
          if (services.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text(
                  S.current.noData,
                  style: TextStyle(color: ColorRes.grey),
                ),
              ),
            )
          else
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: services.length,
                separatorBuilder: (context, index) => Divider(
                  color: ColorRes.grey.withValues(alpha: 0.1),
                ),
                itemBuilder: (context, index) {
                  final service = services[index];
                  final isSelected = selectedService == service['nameEn'];

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      S.current.localeee == 'ar'
                          ? service['nameAr']!
                          : service['nameEn']!,
                      style: TextStyle(
                        color: isSelected ? ColorRes.primary : ColorRes.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check_circle, color: ColorRes.primary)
                        : null,
                    onTap: () {
                      cubit.setFilter(service['nameEn']);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          const Sizer(height: 24),
        ],
      ),
    );
  }
}
