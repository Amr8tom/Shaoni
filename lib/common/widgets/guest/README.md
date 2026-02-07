# Guest Registration Component

## Overview
A beautiful, animated component that prompts guest users to register for the TEAA app or login if they already have an account. Features an animated robot assistant, gradient backgrounds, and easy contact options.

## Features
- ✨ Animated entrance with scale and fade effects
- 🤖 Lottie robot animation with glowing effects
- 💬 Speech bubble design
- 📧 Email contact button
- 📞 Phone contact button
- 🔐 Login button for existing users
- 🎨 Features preview icons
- 🌐 Full localization support (Arabic & English)
- 📏 Uses AppSizes for consistent sizing throughout

## Component Structure

### Main Widget
- `GuestRegistrationPrompt` - Main container with animations

### Sub-Widgets
- `RobotAnimationWidget` - Displays robot with glow effects (uses AppSizes.containerLarge)
- `WelcomeMessageWidget` - Speech bubble with welcome message (uses AppSizes for all spacing)
- `ContactButtonsWidget` - Email, phone, and login buttons (fully sized with AppSizes)
- `FeaturesPreviewWidget` - Icons showing available features (AppSizes for dimensions)

## AppSizes Usage

All components use `AppSizes` properties for consistent sizing:

### Spacing
- `AppSizes.ld` (24.sp) - Main padding
- `AppSizes.xl` (32.sp) - Section spacing
- `AppSizes.md` (16.sp) - Standard spacing
- `AppSizes.sm` (8.sp) - Small spacing

### Sizes
- `AppSizes.containerLarge` (200.h) - Robot animation
- `AppSizes.containerSmall` (60.h) - Feature icons
- `AppSizes.iconMd` (24.sp) - Standard icons
- `AppSizes.iconXLarge` (48.w) - Large icons

### Typography
- `AppSizes.fontSizeXLg` (28.sp) - Main heading
- `AppSizes.fontSizeSm` (16.sp) - Body text
- Ratios like `* 0.875` or `* 1.125` for specific sizes

### Border Radius
- `AppSizes.borderRadiusLg` (12.r) - Containers
- `AppSizes.md` (16.r) - Buttons

**Note**: No new properties were added to AppSizes. All sizing uses existing properties or their ratios.

## Usage

### Basic Usage
```dart
import '../../common/widgets/guest/guest_registration_prompt.dart';

Scaffold(
  body: GuestRegistrationPrompt(),
)
```

### With Navigation
```dart
// Navigate to guest screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AskGuestToRegisterScreen(),
  ),
);
```

### Conditional Rendering
```dart
if (user == null) {
  return GuestRegistrationPrompt();
} else {
  return HomeScreen();
}
```

## Login Option

The component now includes a login button with:
- Divider with "Already have an account?" text
- Green gradient button
- Navigates to `/login` route
- Uses `S.current.login` for localization
- Uses `S.current.alreadyYouHaveAccount` for the divider text

## Localization Keys

### English (intl_en.arb)
```json
"guestWelcome": "Welcome!",
"guestAssistant": "I am your smart assistant in TEAA app",
"guestUnlockFeatures": "To access all amazing app features",
"guestContactUs": "Please contact us to create your account",
"guestContactEmail": "Contact via Email",
"guestContactPhone": "Call us directly",
"guestAccessTo": "You will be able to access:",
"guestFeatureMeals": "Meals",
"guestFeatureGroups": "Groups",
"guestFeatureResidence": "Residence",
"guestFeatureActivities": "Activities",
"alreadyYouHaveAccount": "already you have an account?",
"login": "Login"
```

### Arabic (intl_ar.arb)
```json
"guestWelcome": "مرحباً بك!",
"guestAssistant": "أنا مساعدك الذكي في تطبيق TEAA",
"guestUnlockFeatures": "للاستفادة من جميع مميزات التطبيق الرائعة",
"guestContactUs": "يرجى التواصل معنا لإنشاء حساب خاص بك",
"guestContactEmail": "تواصل عبر البريد الإلكتروني",
"guestContactPhone": "اتصل بنا مباشرة",
"guestAccessTo": "ستتمكن من الوصول إلى:",
"guestFeatureMeals": "الوجبات",
"guestFeatureGroups": "المجموعات",
"guestFeatureResidence": "السكن",
"guestFeatureActivities": "الأنشطة",
"alreadyYouHaveAccount": "هل لديك حساب بالفعل؟",
"login": "تسجيل الدخول"
```

## Contact Configuration

Update contact information in `ContactButtonsWidget`:
```dart
// Email
path: 'king88amr@gmail.com'

// Phone
path: '+201067663826'
```

## Animation Details
- **Duration**: 1500ms
- **Scale Animation**: 0.8 to 1.0 with elastic curve
- **Fade Animation**: 0.0 to 1.0 with ease-in curve

## Color Scheme
- Primary: Blue gradient
- Secondary: Yellow gradient  
- Success: Green gradient (login button)
- Background: White with subtle gradients
- Shadows: Soft primary color shadows

## Dependencies
- `lottie` - For robot animation
- `url_launcher` - For email and phone links
- `flutter_screenutil` - For responsive sizing
- Flutter's built-in animation framework

## Files Structure
```
lib/common/widgets/guest/
├── guest_registration_prompt.dart      # Main widget
├── robot_animation_widget.dart         # Robot with glow
├── welcome_message_widget.dart         # Speech bubble
├── contact_buttons_widget.dart         # Contact + login options
├── features_preview_widget.dart        # Feature icons
└── README.md                           # This file

lib/features/navigation/presentation/widgets/
└── ask_guest_to_register_to_our_app.dart  # Screen wrapper
```

## Sizing Strategy

All components follow these principles:
1. **Use existing AppSizes properties**
2. **Apply ratios for specific needs** (e.g., `* 0.83` for 50 from 60)
3. **Never add new AppSizes properties**
4. **Maintain consistency across components**

### Examples:
```dart
// Robot circles: containerLarge * 1.4, * 1.2, * 1.0
Container(
  width: AppSizes.containerLarge * 1.4,  // Outer glow
  height: AppSizes.containerLarge * 1.4,
)

// Feature icons: containerSmall * 0.83 ≈ 50
Container(
  width: AppSizes.containerSmall * 0.83,
  height: AppSizes.containerSmall * 0.83,
)

// Small font: fontSizeSm * 0.75 ≈ 12
Text(
  label,
  style: TextStyle(
    fontSize: AppSizes.fontSizeSm * 0.75,
  ),
)
```

## Customization

### Change Robot Animation
Edit `robot_animation_widget.dart`:
```dart
Lottie.asset(
  'your_animation_path.json',
  fit: BoxFit.contain,
)
```

### Modify Colors
All colors use `ColorRes` constants from your app theme.

### Update Features
Edit `features_preview_widget.dart` to add/remove features:
```dart
_FeatureIcon(
  icon: Icons.your_icon,
  label: S.current.yourLabel,
)
```

### Change Sizing
Adjust ratios in individual widgets without modifying AppSizes class:
```dart
// Want a bigger robot? Increase the multiplier
width: AppSizes.containerLarge * 1.6  // instead of 1.4
```

## Notes
- Component is fully responsive using ScreenUtil
- Supports RTL languages
- All text is localized
- Animations are smooth and performant
- Contact actions open native apps (email client, phone dialer)
- Login button navigates to `/login` route
- All sizing uses AppSizes for consistency

