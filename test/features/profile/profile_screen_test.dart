import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaoni/features/profile/profile_screen.dart';

void main() {
  group('ProfileScreen Widget Tests', () {
    testWidgets('ProfileScreen should render all required elements',
        (WidgetTester tester) async {
      // Build the ProfileScreen widget wrapped in MaterialApp for proper testing
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: ProfileScreen(),
          ),
        ),
      );

      // Wait for all animations to complete
      await tester.pumpAndSettle();

      // Verify profile fields exist
      expect(find.byType(ProfileField), findsWidgets);
      
      // Verify at least 6 profile fields (name, phone, email, position, department, password)
      expect(find.byType(ProfileField), findsNWidgets(6));

      // Verify avatar is displayed
      expect(find.byType(CircleAvatar), findsOneWidget);

      // Verify update button exists
      expect(find.text('Update'), findsOneWidget);
    });

    testWidgets('ProfileScreen should have settings section',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: ProfileScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Scroll to find settings items
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
      await tester.pumpAndSettle();

      // Verify settings menu items exist
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Privacy & Security'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Help & Support'), findsOneWidget);
    });

    testWidgets('ProfileScreen should display avatar with edit badge',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: ProfileScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify CircleAvatar exists (profile picture)
      expect(find.byType(CircleAvatar), findsOneWidget);

      // Verify edit icon exists for avatar
      final editIcons = find.byIcon(Icons.edit_outlined);
      expect(editIcons, findsWidgets);
    });

    testWidgets('Settings items should be tappable',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: ProfileScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Scroll to settings section
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
      await tester.pumpAndSettle();

      // Tap on Notifications item (should not crash)
      await tester.tap(find.text('Notifications'));
      await tester.pumpAndSettle();

      // Test passes if no exception is thrown
    });
  });

  group('ProfileField Widget Tests', () {
    testWidgets('ProfileField should display text correctly',
        (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Test Value');

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: ProfileField(
                controller: controller,
                trailingIcon: Icons.person,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify the text field displays the controller's text
      expect(find.text('Test Value'), findsOneWidget);

      // Verify trailing icon exists
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('ProfileField should have edit button',
        (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Test');

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: ProfileField(controller: controller),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify edit icon exists
      expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
    });

    testWidgets('ProfileField should support obscure text for password',
        (WidgetTester tester) async {
      final controller = TextEditingController(text: 'password123');

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: ProfileField(
                controller: controller,
                isObscure: true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find the TextFormField
      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      
      // Verify obscureText is true
      expect(textField.obscureText, isTrue);
    });
  });
}
