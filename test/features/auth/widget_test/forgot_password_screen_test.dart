import 'package:child_health_story/core/constants/strings/validation_messages.dart';
import 'package:child_health_story/features/auth/presentation/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:child_health_story/core/constants/path_constants.dart';

void main() {
  group('ForgotPasswordScreen Widget Tests', () {
    Future<void> pumpForgotPasswordScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const ForgotPasswordScreen(),
          routes: {
            PathConstants.otpScreen: (context) => const Placeholder(key: Key('otpScreen')),
          },
        ),
      );
    }

    testWidgets('shows validation errors for empty fields', (tester) async {
      await pumpForgotPasswordScreen(tester);

      final createAccountButton = find.text(AppStrings.shareOTPText);
      await tester.tap(createAccountButton);
      await tester.pump();

      expect(find.textContaining('Please enter'), findsWidgets);
    });

    testWidgets('shows validation error for invalid email', (tester) async {
      await pumpForgotPasswordScreen(tester);

      await tester.enterText(find.byType(TextFormField).at(0), 'invalidemail');
      await tester.tap(find.text(AppStrings.shareOTPText));
      await tester.pump();

      expect(find.text(ValidationMessages.plsEnterValidEmail), findsOneWidget);
    });

    testWidgets('navigates to otp screen on entering valid email and tapping shareotp', (WidgetTester tester) async {
      await pumpForgotPasswordScreen(tester);

      // Find email fields
      final emailField = find.byType(TextFormField).first;

      // Enter valid email and password
      await tester.enterText(emailField, 'test@example.com');

      // Tap the continue button
      final continueBtn = find.text(AppStrings.shareOTPText);
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      // Verify navigation to addChild screen
      expect(find.byKey(const Key('otpScreen')), findsOneWidget);
    });
  });
}
