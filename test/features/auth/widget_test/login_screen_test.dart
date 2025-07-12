import 'package:child_health_story/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:child_health_story/core/constants/path_constants.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    Future<void> pumpLoginScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LoginScreen(),
          routes: {
            PathConstants.forgotPasswordScreen: (context) => const Placeholder(key: Key('forgotPasswordScreen')),
            PathConstants.addchild: (context) => const Placeholder(key: Key('addChildScreen')),
          },
        ),
      );
    }

    testWidgets('shows validation error for invalid email', (WidgetTester tester) async {
      await pumpLoginScreen(tester);
      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;

      await tester.enterText(emailField, 'invalidemail');
      await tester.enterText(passwordField, 'password123');

      final continueBtn = find.text(AppStrings.continueText);
      await tester.tap(continueBtn);
      await tester.pump();

      expect(find.text('Email is invalid'), findsOneWidget);
    });

    testWidgets('navigates to addChild on entering valid email and password and tapping continue', (WidgetTester tester) async {
      await pumpLoginScreen(tester);

      // Find email and password fields
      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;

      // Enter valid email and password
      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'Password@123'); // Adjust to match your validator rules

      // Tap the continue button
      final continueBtn = find.text(AppStrings.continueText);
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      // Verify navigation to addChild screen
      expect(find.byKey(const Key('addChildScreen')), findsOneWidget);
    });


    testWidgets('navigates to forgotPasswordScreen on tapping forgot password', (WidgetTester tester) async {
      await pumpLoginScreen(tester);

      // Find the forgot password button by its visible text
      final forgotPasswordBtn = find.text(AppStrings.forgotPasswordText);

      // Tap the button
      await tester.tap(forgotPasswordBtn);
      await tester.pumpAndSettle();

      // Verify navigation occurred to forgotPasswordScreen (Placeholder with key)
      expect(find.byKey(const Key('forgotPasswordScreen')), findsOneWidget);
    });


  });
}
