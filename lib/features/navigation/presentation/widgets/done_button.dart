import 'package:flutter/material.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';

import '../../../../generated/l10n.dart';

class DoneButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  const DoneButton({super.key, this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: AppSizes.fullWidth / 1.2,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: ColorRes.grey.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text ?? S.current.done,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorRes.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
