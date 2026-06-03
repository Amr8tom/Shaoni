import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/generated/l10n.dart';

import '../../../../core/routing/service_route_resolver.dart';

class UpdateRequestButton extends StatelessWidget {
  final String requestID;
  final String serviceType;

  const UpdateRequestButton({
    super.key,
    required this.requestID,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding * 1.8),
      child: GestureDetector(
        onTap: () => context.pushNamed(
          ServiceRouteResolver.updateRouteFor(serviceType),
          arguments: {'requestId': int.tryParse(requestID)},
        ),
        child: Container(
          height: AppSizes.heightcontainer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.xxl),
            color: ColorRes.primary,
            boxShadow: [
              BoxShadow(
                color: ColorRes.primary.withValues(alpha: 0.30),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
              const Sizer(width: 8),
              Text(
                S.current.updateRequest,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: ColorRes.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
