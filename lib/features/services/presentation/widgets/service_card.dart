import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';

class ServiceCard extends StatelessWidget {
  final String img, title;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.img,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding * 1),
        decoration: BoxDecoration(
          border: Border.all(color: ColorRes.greyForBorders, width: 1),
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusXLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              fit: BoxFit.fill,
              height: AppSizes.heightcontainer * 1.3,
            ),
            const Sizer(height: 18),
            Flexible(
              child: Text(
                maxLines: 2,
                title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorRes.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
