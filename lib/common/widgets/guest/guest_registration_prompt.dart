import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import 'contact_buttons_widget.dart';
import 'features_preview_widget.dart';
// import '../../../features/robot/presentation/robot_animation_widget.dart';
import 'welcome_message_widget.dart';

/// Main guest registration prompt screen with animations
class GuestRegistrationPrompt extends StatefulWidget {
  const GuestRegistrationPrompt({super.key});

  @override
  State<GuestRegistrationPrompt> createState() =>
      _GuestRegistrationPromptState();
}

class _GuestRegistrationPromptState extends State<GuestRegistrationPrompt>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.ld),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Welcome Message at the top
                  const WelcomeMessageWidget(),


                  SizedBox(height: AppSizes.xl),

                  /// Contact Buttons
                  const ContactButtonsWidget(),

                  SizedBox(height: AppSizes.ld),

                  /// Features Icons
                  const FeaturesPreviewWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
