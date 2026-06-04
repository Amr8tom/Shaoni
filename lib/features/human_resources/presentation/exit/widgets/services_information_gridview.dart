import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/request_services_Entity.dart';
import '../../controller/exit_permission/exit_request_service_cubit.dart';

class ServicesInformationGridview extends StatelessWidget {
  const ServicesInformationGridview({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RequestServicesEntity> questions = [
      RequestServicesEntity(
        id: '232323',
        question: S.current.whenAndWhyUsed,
        answer: S.current.whenAndWhyDescription,
      ),
      RequestServicesEntity(
        id: '232323',
        question: S.current.allowedDurationRules,
        answer: S.current.duringWorkHours,
      ),
      RequestServicesEntity(
        id: '232323',
        question: S.current.processingType,
        answer: '00000000000',
      ),
      RequestServicesEntity(
        id: '232323',
        question: S.current.slaResponseTime,
        answer: '00000000000',
      ),
    ];
    return BlocBuilder<ExitRequestServiceCubit, ExitRequestServiceState>(
      builder: (context, state) {
        final controller = context.read<ExitRequestServiceCubit>();

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final isExpanded = state.expandedIndex == index;
            return Padding(
              padding: EdgeInsets.only(bottom: AppSizes.padding),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                  boxShadow: [
                    BoxShadow(
                      color: ColorRes.grey.withValues(alpha: 0.2),
                      blurRadius: AppSizes.xs,
                      offset: Offset(0, AppSizes.xs / 2),
                    ),
                  ],
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: ColorRes.transparent,
                    expansionTileTheme: ExpansionTileThemeData(
                      tilePadding: EdgeInsets.all(AppSizes.padding),
                      childrenPadding: EdgeInsets.zero,
                    ),
                  ),
                  child: ExpansionTile(
                    key: ValueKey(
                        'expansion_tile_${index}_${state.expandedIndex}'),
                    initiallyExpanded: isExpanded,
                    onExpansionChanged: (expanded) {
                      controller.setExpandedIndex(expanded ? index : null);
                    },
                    tilePadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                      vertical: AppSizes.sm / 2,
                    ),
                    title: Text(
                      questions[index].question,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color:
                                isExpanded ? ColorRes.primary : ColorRes.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                      maxLines: 2,
                    ),
                    trailing: Container(
                      width: AppSizes.iconMd,
                      height: AppSizes.iconMd,
                      padding: EdgeInsets.all(AppSizes.xs / 1.5),
                      decoration: BoxDecoration(
                        color: ColorRes.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadiusSm,
                        ),
                      ),
                      child: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down_outlined,
                        color: ColorRes.black,
                        size: AppSizes.iconMd,
                      ),
                    ),
                    iconColor: ColorRes.transparent,
                    collapsedIconColor: ColorRes.transparent,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(AppSizes.sm),
                        padding: EdgeInsets.all(AppSizes.md),
                        child: Text(
                          questions[index].answer,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorRes.black,
                                    height: 1.5,
                                    fontSize: 13,
                                  ),
                          maxLines: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
