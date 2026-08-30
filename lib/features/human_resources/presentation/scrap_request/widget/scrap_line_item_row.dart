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
    required this.lots,
    required this.qtyController,
    required this.reasonController,
    required this.onLotChanged,
    required this.onDelete,
  });

  final ScrapLineItemState item;
  final List<dynamic> lots;
  final TextEditingController? qtyController;
  final TextEditingController? reasonController;
  final void Function(int id, String name) onLotChanged;
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

          /// Product (read-only from custody)
          Text(
            S.current.product,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorRes.grey2,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Sizer(height: 4),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding * 0.75,
              vertical: AppSizes.padding * 0.6,
            ),
            decoration: BoxDecoration(
              color: ColorRes.grey5,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              border: Border.all(color: ColorRes.grey5),
            ),
            child: Text(
              item.productName.isNotEmpty
                  ? item.productName
                  : S.current.selectCustodyFirst,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: item.productName.isNotEmpty
                        ? ColorRes.black
                        : ColorRes.grey2,
                  ),
            ),
          ),
          const Sizer(height: 8),

          /// Lot dropdown
          _DropdownField<dynamic>(
            hint: S.current.selectLot,
            label: S.current.lotNumber,
            value: item.lotId != null ? item.lotName : null,
            items: lots
                .map((l) => DropdownMenuItem<dynamic>(
                      value: l,
                      child: Text(
                        l.name as String,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            onChanged: (l) {
              if (l != null) {
                onLotChanged(l.id as int, l.name as String);
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
