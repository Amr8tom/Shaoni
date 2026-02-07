import 'package:flutter/material.dart';
import '../../../../common/widgets/guest/guest_registration_prompt.dart';

/// Screen that prompts guest users to register or login
/// This can be used in the navigation flow when a guest tries to access protected features
class AskGuestToRegisterScreen extends StatelessWidget {
  const AskGuestToRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: GuestRegistrationPrompt(),
      ),
    );
  }
}

