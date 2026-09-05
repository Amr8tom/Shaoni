import 'package:flutter/material.dart';

import '../../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../controller/scrap_request/scrap_request_cubit.dart';

class ScrapLineItemRow extends StatelessWidget {
  const ScrapLineItemRow({
    super.key,
    required this.item,
    required this.products,
    required this.lots,
    required this.qtyController,
    required this.reasonController,
    required this.onProductChanged,
    required this.onLotChanged,
    required this.onDelete,
  });

  final ScrapLineItemState item;
  final List<ScrapProductOption> products;
  final List<dynamic> lots;
  final TextEditingController? qtyController;
  final TextEditingController? reasonController;
  final void Function(int id, String name) onProductChanged;
  final void Function(int id, String name) onLotChanged;
  final VoidCallback? onDelete;

  /// De-duplicate lots by id so no two [DropdownMenuItem]s share a value.
  List<dynamic> get _uniqueLots {
    final seen = <int>{};
    return lots.where((l) => seen.add(l.id as int)).toList();
  }

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

          /// Product dropdown (chosen from the selected custodies' products)
          _DropdownField<int>(
            hint: products.isEmpty
                ? S.current.selectCustodyFirst
                : S.current.product,
            label: S.current.product,
            value: products.any((p) => p.id == item.productId)
                ? item.productId
                : null,
            items: products
                .map((p) => DropdownMenuItem<int>(
                      value: p.id,
                      child: Text(
                        p.name,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            onChanged: (id) {
              if (id == null) return;
              final selected = products.firstWhere((p) => p.id == id);
              onProductChanged(selected.id, selected.name);
            },
          ),
          const Sizer(height: 8),

          /// Lot dropdown
          _DropdownField<int>(
            hint: S.current.selectLot,
            label: S.current.lotNumber,
            // Guard against a stale selection: if the previously selected lot
            // is not in the current list (e.g. after the custody/product
            // changed), fall back to null instead of crashing the dropdown.
            value:
                _uniqueLots.any((l) => l.id == item.lotId) ? item.lotId : null,
            items: _uniqueLots
                .map((l) => DropdownMenuItem<int>(
                      value: l.id as int,
                      child: Text(
                        l.name as String,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            onChanged: (id) {
              if (id == null) return;
              final selected = _uniqueLots.firstWhere((l) => l.id == id);
              onLotChanged(selected.id as int, selected.name as String);
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

          /// Reason field
          Text(
            S.current.requestReason,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorRes.grey2,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Sizer(height: 4),
          TextFormField(
            controller: reasonController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: S.current.reasonHint,
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

// ── Generic dropdown field ────────────────────────────────────────────────────

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
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ColorRes.grey2,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Sizer(height: 4),
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
