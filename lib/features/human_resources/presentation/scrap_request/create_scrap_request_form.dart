import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_custody.dart';
import 'package:shaoni/features/human_resources/presentation/controller/scrap_request/scrap_request_cubit.dart';
import 'package:shaoni/features/human_resources/presentation/scrap_request/widget/scrap_request_data_widget.dart';

import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../core/constants/asset_resources.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../widgets/general_request_templates/applicant_data_widget.dart';
import '../widgets/general_request_templates/create_delete_buttons.dart';
import '../widgets/general_request_templates/date_data_widget.dart';

class CreateScrapRequestForm extends StatelessWidget {
  final int? requestId;

  const CreateScrapRequestForm({super.key, this.requestId});

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ScrapRequestCubit>(),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
          title: _isEditMode ? S.current.editRequest : S.current.scrapRequest,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<ScrapRequestCubit>();
            return BlocConsumer<ScrapRequestCubit, ScrapRequestState>(
              listener: (context, state) {
                if (state.status.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? S.current.error),
                      backgroundColor: ColorRes.error.withValues(alpha: 0.5),
                    ),
                  );
                }

                if (state.status.isCreateLoaded) {
                  customDialogImgTitleDes(
                    button1: S.current.myOrders,
                    button2: S.current.home,
                    orderNumber: _isEditMode ? '' : (state.requestNumber ?? ''),
                    onTab2: () {
                      context.pushNamedAndRemoveUntil(
                        DRoutesName.navigationMenuRoute,
                        predicate: (route) => false,
                      );
                    },
                    onTab1: () {
                      context.pushNamedAndRemoveUntil(
                        DRoutesName.navigationMenuRoute,
                        predicate: (route) => false,
                      );
                    },
                    context: context,
                    title: _isEditMode
                        ? S.current.requestUpdatedSuccessfully
                        : S.current.requestSentSuccessfully,
                    des: _isEditMode
                        ? S.current.requestUpdatedSuccessfully
                        : S.current.requestSentSuccessfully,
                    imgPath: AssetRes.doubleCorrect,
                    isSvg: true,
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: controller.requestFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding * 1.5),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Sizer(height: 220),

                              const DateDataWidget(),
                              const Sizer(height: 35),

                              ApplicantDataWidget(
                                onOfficeChanged: (id, _) {
                                  controller.officeIdController.text =
                                      id.toString();
                                },
                              ),
                              const Sizer(height: 35),

                              Text(
                                S.current.requestDetails,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const Sizer(height: 16),

                              /// Custody multi-select
                              _CustodyMultiSelect(
                                custodies: state.custodies,
                                selectedIds: state.selectedCustodyIds,
                                onToggle: controller.toggleCustody,
                              ),
                              const Sizer(height: 16),

                              /// Stock request dropdown
                              _LabeledDropdown<dynamic>(
                                label: S.current.stockRequest,
                                hint: S.current.selectStockRequest,
                                value: state.selectedStockRequestId != null
                                    ? state.stockRequests
                                        .cast<dynamic>()
                                        .firstWhere(
                                          (r) =>
                                              r?.id ==
                                              state.selectedStockRequestId,
                                          orElse: () => null,
                                        )
                                    : null,
                                items: state.stockRequests
                                    .map((r) => DropdownMenuItem<dynamic>(
                                          value: r,
                                          child: Text(
                                            r.name,
                                            style:
                                                const TextStyle(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (r) {
                                  if (r != null) {
                                    controller.selectStockRequest(r);
                                  }
                                },
                              ),
                              const Sizer(height: 16),

                              /// Scrap reason dropdown
                              _LabeledDropdown<dynamic>(
                                label: S.current.scrapReason,
                                hint: S.current.selectScrapReason,
                                value: state.selectedReasonId != null
                                    ? state.scrapReasons
                                        .cast<dynamic>()
                                        .firstWhere(
                                          (r) =>
                                              r?.id == state.selectedReasonId,
                                          orElse: () => null,
                                        )
                                    : null,
                                items: state.scrapReasons
                                    .map((r) => DropdownMenuItem<dynamic>(
                                          value: r,
                                          child: Text(
                                            r.name,
                                            style:
                                                const TextStyle(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (r) {
                                  if (r != null) {
                                    controller.selectScrapReason(r);
                                  }
                                },
                              ),
                              const Sizer(height: 16),

                              const ScrapRequestDataWidget(),

                              const Sizer(height: 120),
                            ],
                          ),
                        ),
                        state.status.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: ColorRes.primary,
                                ),
                              )
                            : CreateDeleteButtons(
                                deleteTab: () => controller.resetForm(),
                                createTab: () {
                                  if (controller.requestFormKey.currentState!
                                      .validate()) {
                                    if (_isEditMode) {
                                      controller.updateScrapRequest(
                                          requestId: requestId!);
                                    } else {
                                      controller.createScrapRequest();
                                    }
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// ── Custody multi-select ──────────────────────────────────────────────────────

class _CustodyMultiSelect extends StatelessWidget {
  const _CustodyMultiSelect({
    required this.custodies,
    required this.selectedIds,
    required this.onToggle,
  });

  final List<ScrapCustody> custodies;
  final List<int> selectedIds;
  final void Function(ScrapCustody) onToggle;

  @override
  Widget build(BuildContext context) {
    final selected =
        custodies.where((c) => selectedIds.contains(c.id)).toList();
    final unselected =
        custodies.where((c) => !selectedIds.contains(c.id)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.custody,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const Sizer(height: 6),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.padding * 0.75,
            vertical: AppSizes.padding * 0.5,
          ),
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
            border: Border.all(color: ColorRes.greyForBorders),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selected.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: 2,
                  children: selected
                      .map((c) => Chip(
                            label: Text(
                              c.name,
                              style: const TextStyle(fontSize: 12),
                            ),
                            onDeleted: () => onToggle(c),
                            deleteIcon: const Icon(Icons.close, size: 16),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            backgroundColor:
                                ColorRes.primary.withValues(alpha: 0.10),
                          ))
                      .toList(),
                ),
              DropdownButtonHideUnderline(
                child: DropdownButton<ScrapCustody>(
                  isExpanded: true,
                  value: null,
                  hint: Text(
                    S.current.selectCustody,
                    style: const TextStyle(fontSize: 12),
                  ),
                  items: unselected
                      .map((c) => DropdownMenuItem<ScrapCustody>(
                            value: c,
                            child: Text(
                              c.name,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (c) {
                    if (c != null) onToggle(c);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Labeled dropdown ──────────────────────────────────────────────────────────

class _LabeledDropdown<T> extends StatelessWidget {
  const _LabeledDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const Sizer(height: 6),
        DropdownButtonFormField<T>(
          hint: Text(hint, style: const TextStyle(fontSize: 12)),
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding * 0.75,
              vertical: AppSizes.padding * 0.5,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.greyForBorders),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.greyForBorders),
            ),
            filled: true,
            fillColor: ColorRes.white,
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
