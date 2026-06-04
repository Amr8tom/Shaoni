import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../controller/product_order/product_order_cubit.dart';

class ProductOrderDataWidget extends StatelessWidget {
  const ProductOrderDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductOrderCubit, ProductOrderState>(
      builder: (context, state) {
        final controller = context.read<ProductOrderCubit>();
        return Container(
          padding: EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
            border: Border.all(color: ColorRes.greyForBorders),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Section title
              Text(
                S.current.requestLines,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 8),

              /// Line items
              ...state.lineItems.map(
                (item) => _LineItemRow(
                  key: ValueKey(item.localId),
                  item: item,
                  categories: state.categories,
                  products:
                      state.productsByCategory[item.categoryId] ?? const [],
                  qtyController: controller.qtyController(item.localId),
                  notesController: controller.notesController(item.localId),
                  onCategoryChanged: (id, name) =>
                      controller.updateItemCategory(item.localId, id, name),
                  onProductChanged: (id, name) =>
                      controller.updateItemProduct(item.localId, id, name),
                  onDelete: state.lineItems.length > 1
                      ? () => controller.removeLineItem(item.localId)
                      : null,
                ),
              ),

              const Sizer(height: 12),

              /// Add line button
              GestureDetector(
                onTap: controller.addLineItem,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizes.padding * 0.6,
                    horizontal: AppSizes.padding,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorRes.primary, style: BorderStyle.solid),
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusMd),
                    color: ColorRes.primary.withValues(alpha: 0.06),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: ColorRes.primary, size: 18),
                      const Sizer(width: 6.4),
                      Text(
                        S.current.addLine,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorRes.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Single line item row ─────────────────────────────────────────────────────

class _LineItemRow extends StatelessWidget {
  const _LineItemRow({
    super.key,
    required this.item,
    required this.categories,
    required this.products,
    required this.qtyController,
    required this.notesController,
    required this.onCategoryChanged,
    required this.onProductChanged,
    required this.onDelete,
  });

  final LineItemState item;
  final List<dynamic> categories;
  final List<dynamic> products;
  final TextEditingController? qtyController;
  final TextEditingController? notesController;
  final void Function(int id, String name) onCategoryChanged;
  final void Function(int id, String name) onProductChanged;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(AppSizes.padding * 0.75),
      decoration: BoxDecoration(
        color: ColorRes.grey6,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        border: Border.all(color: ColorRes.grey5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Delete button row
          if (onDelete != null)
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: ColorRes.error,
                  size: 20,
                ),
              ),
            ),

          /// Category dropdown
          _DropdownField<dynamic>(
            hint: S.current.selectProductCategory,
            label: S.current.productCategory,
            value: item.categoryId != null ? item.categoryName : null,
            items: categories
                .map((c) => DropdownMenuItem<dynamic>(
                      value: c,
                      child: Text(
                        c.name as String,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            onChanged: (c) {
              if (c != null) {
                onCategoryChanged(c.id as int, c.name as String);
              }
            },
          ),
          const Sizer(height: 8),

          /// Product dropdown
          _DropdownField<dynamic>(
            hint: S.current.selectProduct,
            label: S.current.product,
            value: item.productId != null ? item.productName : null,
            items: products
                .map((p) => DropdownMenuItem<dynamic>(
                      value: p,
                      child: Text(
                        p.name as String,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            onChanged: (p) {
              if (p != null) {
                onProductChanged(p.id as int, p.name as String);
              }
            },
          ),
          const Sizer(height: 8),

          /// Quantity field
          Text(
            S.current.quantity,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorRes.grey2,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Sizer(height: 4),
          TextFormField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '1',
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSizes.padding * 0.75,
                vertical: AppSizes.padding * 0.5,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                borderSide: BorderSide(color: ColorRes.grey5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                borderSide: BorderSide(color: ColorRes.grey5),
              ),
              filled: true,
              fillColor: ColorRes.white,
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return null;
              final n = int.tryParse(v);
              if (n == null || n < 1) return S.current.invalidQuantity;
              return null;
            },
          ),
          const Sizer(height: 8),

          /// Notes field
          Text(
            S.current.notes,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorRes.grey2,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Sizer(height: 4),
          TextFormField(
            controller: notesController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: S.current.notesHint,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSizes.padding * 0.75,
                vertical: AppSizes.padding * 0.5,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                borderSide: BorderSide(color: ColorRes.grey5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                borderSide: BorderSide(color: ColorRes.grey5),
              ),
              filled: true,
              fillColor: ColorRes.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Generic dropdown field ───────────────────────────────────────────────────

class _DropdownField<T> extends StatelessWidget {
  const _DropdownField({
    required this.hint,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String hint;
  final String label;
  final String? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ColorRes.grey2,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Sizer(height: 4),
        DropdownButtonFormField<T>(
          hint: Text(hint, style: const TextStyle(fontSize: 12)),
          value: null,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding * 0.75,
              vertical: AppSizes.padding * 0.5,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.grey5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.grey5),
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
