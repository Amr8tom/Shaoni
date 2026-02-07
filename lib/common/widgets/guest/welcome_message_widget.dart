import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/colors.dart';
import '../../../generated/l10n.dart';

/// Widget that displays the welcome message as a speech bubble from robot
class WelcomeMessageWidget extends StatelessWidget {
  const WelcomeMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// Speech Bubble Container
        Container(
          padding: EdgeInsets.all( AppSizes.md),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorRes.white,
                ColorRes.primary.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            border: Border.all(
              color: ColorRes.primary.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorRes.primary.withOpacity(0.15),
                blurRadius: AppSizes.md,
                offset: Offset(0, AppSizes.sm),
              ),
            ],
          ),
          child: Column(
            children: [
              /// Welcome message
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.waving_hand,
                    size: AppSizes.iconMd,
                    color: ColorRes.yellow,
                  ),
                  SizedBox(width: AppSizes.sm),
                  Text(
                    S.current.guestWelcome,
                    style: TextStyle(
                      fontSize: AppSizes.fontSizeLg,
                      fontWeight: FontWeight.bold,
                      color: ColorRes.primary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSizes.sm),

              /// Assistant intro
              Text(
                S.current.guestAssistant,
                style: TextStyle(
                  fontSize: AppSizes.fontSizeSm * 0.875, // ~14
                  color: ColorRes.grey,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSizes.md),

              /// Divider
              Divider(
                color: ColorRes.primary.withOpacity(0.2),
                thickness: 1,
              ),

              SizedBox(height: AppSizes.sm),

              /// Main message
              Text(
                S.current.guestUnlockFeatures,
                style: TextStyle(
                  fontSize: AppSizes.fontSizeSm,
                  color: ColorRes.primary,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSizes.xs),

              Text(
                S.current.guestContactUs,
                style: TextStyle(
                  fontSize: AppSizes.fontSizeSm * 0.875, // ~14
                  color: ColorRes.grey,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        /// Speech bubble tail pointing downward to robot
        Positioned(
          bottom: -AppSizes.md + 2, // Slightly below the bubble
          left: 0,
          right: AppSizes.padding*5,
          child: Center(
            child: CustomPaint(
              size: Size(AppSizes.xl, AppSizes.md),
              painter: _TrianglePainter(color: ColorRes.white),
            ),
          ),
        ),

        /// Border for the tail
        Positioned(
          bottom: -AppSizes.md + 2, // Slightly below the bubble
          left: 0,
          right: AppSizes.padding*5,
          child: Center(
            child: CustomPaint(
              size: Size(AppSizes.xl, AppSizes.md),
              painter: _TrianglePainter(
                color: ColorRes.primary.withOpacity(0.3),
                isBorder: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom painter for speech bubble triangle pointing downward to robot
class _TrianglePainter extends CustomPainter {
  final Color color;
  final bool isBorder;

  _TrianglePainter({required this.color, this.isBorder = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = isBorder ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeWidth = isBorder ? 2 : 0;

    final path = Path()
      ..moveTo(size.width * 0.3, 0) // Top left
      ..lineTo(size.width * 0.7, 0) // Top right
      ..lineTo(size.width / 2, size.height) // Bottom point (pointing down ↓ to robot)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

