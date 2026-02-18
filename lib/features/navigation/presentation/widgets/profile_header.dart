import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class ProfileHeader extends StatelessWidget {
  final String? userName;
  final String? userImage;

  const ProfileHeader({
    super.key,
    this.userName,
    this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(DRoutesName.profileRoute);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// Profile avatar with enhanced design
          Container(
            // width: AppSizes.imageSize*2,
            // height: AppSizes.heightcontainer*1.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: EdgeInsets.all(3.w), // This creates the white border
            child: Container(
              // width: 100,
              // height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorRes.primary.withValues(alpha: 0.1),
              ),
              child: ClipOval(
                child: userImage != null
                    ? Image.network(
                  userImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildDefaultAvatar();
                  },
                )
                    : _buildDefaultAvatar(),
              ),
            ),
          ),

          Sizer(width: 10),
          /// User info column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.current.welcome,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: AppSizes.fontSizeSm,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                userName ?? "مصطفى ذكريا محمد",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppSizes.fontSizeMd,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: 0.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Image.asset(
      AssetRes.homeAvatarInfo,
      fit: BoxFit.fill,
    );
  }
}
