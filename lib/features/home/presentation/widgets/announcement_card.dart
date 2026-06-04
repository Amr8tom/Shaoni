import 'package:flutter/material.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

/// Teal "Announcement" banner used at the bottom of the Home screen.
///
/// Uses the app's primary color as the background with two subtle white
/// decorative bubbles for visual interest, matches the rounded card
/// vocabulary used elsewhere in the app.
class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.title,
    required this.body,
    this.onTap,
  });

  /// Bold heading (e.g. `S.current.announcement`).
  final String title;

  /// Body / message paragraph.
  final String body;

  /// Optional tap callback (e.g. open the announcement details).
  final VoidCallback? onTap;

  /// Convenience constructor used by the Home screen — pulls localized
  /// strings from `S.current` so the call site stays minimal.
  factory AnnouncementCard.attendance({Key? key, VoidCallback? onTap}) {
    return AnnouncementCard(
      key: key,
      title: S.current.announcement,
      body: S.current.attendanceAnnouncementBody,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorRes.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        child: Container(
          padding: EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            color: ColorRes.primary,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            boxShadow: [
              BoxShadow(
                color: ColorRes.primary.withValues(alpha: 0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            child: Stack(
              children: [
                /// Decorative blobs — soft white circles for visual depth.
                Positioned(
                  bottom: -30,
                  right: -20,
                  child: _DecorBlob(
                    size: 120,
                    color: ColorRes.white.withValues(alpha: 0.10),
                  ),
                ),
                Positioned(
                  top: -40,
                  left: -10,
                  child: _DecorBlob(
                    size: 100,
                    color: ColorRes.white.withValues(alpha: 0.08),
                  ),
                ),

                /// Content
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Info icon avatar
                    Container(
                      width: AppSizes.iconLg * 1.4,
                      height: AppSizes.iconLg * 1.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorRes.white.withValues(alpha: 0.20),
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadiusMd),
                        border: Border.all(
                          color: ColorRes.white.withValues(alpha: 0.30),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: ColorRes.white,
                        size: AppSizes.iconMd,
                      ),
                    ),
                    const Sizer(width: 12),

                    /// Title + body
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: ColorRes.white,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const Sizer(height: 6),
                          Text(
                            body,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorRes.white.withValues(alpha: 0.92),
                                  height: 1.5,
                                  fontSize: AppSizes.fontSizeSm,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Soft circular blob used as background decoration on the announcement
/// card — keeps the surface from feeling flat.
class _DecorBlob extends StatelessWidget {
  const _DecorBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
