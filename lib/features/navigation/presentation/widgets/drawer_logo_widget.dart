import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class DrawerLogoWidget extends StatelessWidget {
  const DrawerLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(AppSizes.padding/2),
        child: Row(
mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AssetRes.logo,
                height: AppSizes.heightcontainer,
              ),
            ),
            const Sizer(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    S.current.designDevelopment,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorRes.grey,
                    ),
                  ),
                ),

                const Sizer(height: 2),

                Center(
                  child: Text(
                    S.current.ejad,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorRes.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

