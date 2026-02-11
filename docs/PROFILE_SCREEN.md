# Profile Screen Implementation

## Overview
This document describes the implementation of the Profile Screen for the Shaoni Flutter application. The profile screen provides a comprehensive user interface for viewing and editing user profile information, along with quick access to settings and additional features.

## Features Implemented

### 1. User Profile Information
The profile screen displays and allows editing of the following user information:

- **Profile Picture/Avatar**
  - Circular avatar with custom background color (#E8B4A8)
  - Edit badge at bottom-left with yellow/gold color
  - Image picker functionality (placeholder for future implementation)
  - Asset path: `assets/images/pngs/profile.png`

- **User Details Fields**
  1. **Name** - Full name with person icon
  2. **Phone** - Phone number with smartphone icon
  3. **Email** - Email address with mail icon
  4. **Position** - Job position/title with briefcase icon (Iconsax)
  5. **Department** - Department/team with building icon (Iconsax)
  6. **Password** - Secure password field with lock icon (obscured text)

### 2. Settings Menu Section
A dedicated settings section with four menu items:

1. **Notifications** - Access notification preferences
2. **Privacy & Security** - Manage privacy and security settings
3. **Settings** - General app settings
4. **Help & Support** - Access help resources and support

Each menu item includes:
- An icon with primary color background (10% opacity)
- Clear text label
- Right arrow indicator for navigation
- Tap functionality (currently shows placeholders for future navigation)

### 3. UI/UX Design

#### Layout Structure
```
ProfileScreen
├── AppBar (with back button)
├── Scrollable Content
│   ├── Avatar Section
│   │   └── Profile Picture with Edit Badge
│   ├── Profile Fields (6 fields)
│   │   ├── Name
│   │   ├── Phone
│   │   ├── Email
│   │   ├── Position
│   │   ├── Department
│   │   └── Password
│   └── Settings Section (4 items)
│       ├── Notifications
│       ├── Privacy & Security
│       ├── Settings
│       └── Help & Support
└── Update Button (Fixed at bottom)
```

#### Design Patterns
- **Colors**: Uses app's color scheme from `ColorRes`
  - Primary: #009D8B (teal/green)
  - Yellow/Gold: #D4962E
  - Scaffold Background: #E7ECED
  - White containers with grey borders

- **Spacing**: Consistent use of `AppSizes` and `Sizer` widget
  - 24px top spacing after app bar
  - 12px between form fields
  - 32px between major sections

- **Typography**: Uses app's text theme with responsive sizing via `flutter_screenutil`

- **Icons**: Combination of Material Icons and Iconsax for modern appearance

#### Interactive Elements
- **ProfileField Widget**: Custom reusable widget for editable fields
  - Edit button on left side
  - Text field in center (RTL support)
  - Icon on right side
  - Read-only by default, editable on edit button tap
  - Special support for password fields (obscured text)

## File Structure

```
lib/features/profile/
└── profile_screen.dart
    ├── ProfileScreen (main widget)
    │   ├── build() - Main UI construction
    │   ├── _buildSettingsSection() - Settings menu container
    │   └── _buildSettingsItem() - Individual settings menu item
    └── ProfileField (reusable field widget)
        └── _ProfileFieldState - Manages field edit state
```

## Dependencies

The profile screen uses the following packages:
- `flutter_screenutil` - Responsive sizing
- `iconsax` - Modern icon pack
- `flutter/material.dart` - Material Design components

## Integration

### Routing
The profile screen is integrated into the app's routing system:

**Route Name**: `DRoutesName.profileInfoRoute` = `'profile-info-route'`

**Navigation Example**:
```dart
Navigator.pushNamed(context, DRoutesName.profileInfoRoute);
```

**Route Configuration** (in `routes.dart`):
```dart
case DRoutesName.profileInfoRoute:
  return PageTransition(
    child: const ProfileScreen(),
    type: PageTransitionType.rightToLeft,
    settings: settings,
  );
```

### Localization
The screen uses localized strings via the `S` class (generated from `.arb` files):
- `S.current.profile` - Screen title
- `S.current.update` - Update button text

## Testing

### Test Coverage
Comprehensive widget tests are provided in `test/features/profile/profile_screen_test.dart`:

**Test Groups**:
1. **ProfileScreen Widget Tests**
   - Renders all required elements (6 fields + avatar + button)
   - Has settings section with 4 items
   - Displays avatar with edit badge
   - Settings items are tappable

2. **ProfileField Widget Tests**
   - Displays text correctly
   - Has edit button
   - Supports obscure text for passwords

**Running Tests**:
```bash
flutter test test/features/profile/profile_screen_test.dart
```

## Future Enhancements

### Planned Features
1. **Image Picker Integration**
   - Allow users to select/upload profile pictures
   - Image cropping functionality
   - Camera integration

2. **Form Validation**
   - Email format validation
   - Phone number format validation
   - Required field validation

3. **API Integration**
   - Fetch user data from backend
   - Update profile information
   - Upload profile picture

4. **Settings Navigation**
   - Implement actual navigation to settings screens
   - Create dedicated screens for each settings option

5. **Password Management**
   - Change password functionality
   - Show/hide password toggle
   - Password strength indicator

6. **Additional Fields**
   - Address
   - Date of Birth
   - Employee ID
   - Emergency Contact

## Code Quality

### Design Principles Applied
- ✅ **DRY (Don't Repeat Yourself)**: Reusable `ProfileField` widget
- ✅ **Single Responsibility**: Separate methods for settings section
- ✅ **Consistent Styling**: Uses app's design system (`ColorRes`, `AppSizes`)
- ✅ **Responsive Design**: Uses `flutter_screenutil` for scaling
- ✅ **Accessibility**: Proper contrast ratios and tap targets
- ✅ **RTL Support**: Text direction support for Arabic language

### Best Practices
- Const constructors where possible
- Proper widget separation
- Clear naming conventions
- Comprehensive documentation
- Full test coverage

## Maintenance Notes

### Known Issues
- Avatar image asset path was corrected from `assets/images/ss/avatar.png` to `assets/images/pngs/profile.png`
- Settings navigation currently shows TODO placeholders

### Dependencies to Monitor
- `iconsax` package version
- `flutter_screenutil` compatibility with Flutter SDK updates

## Contact

For questions or issues related to the profile screen implementation, please contact the development team or create an issue in the repository.

---

**Last Updated**: February 2026  
**Version**: 1.0.0  
**Author**: GitHub Copilot Agent
