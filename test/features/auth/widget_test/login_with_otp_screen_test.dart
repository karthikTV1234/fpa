import 'package:child_health_story/features/auth/presentation/login_with_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:child_health_story/core/constants/path_constants.dart';
import 'package:child_health_story/core/constants/strings/validation_messages.dart';

void main() {
  Future<void> pumpLoginWithOtpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const LoginWithOtp(),
        routes: {
          PathConstants.otpScreen: (context) => const Placeholder(key: Key('otpScreen')),
          PathConstants.signUpScreen: (context) => const Placeholder(key: Key('signUpScreen')),
        },
      ),
    );
  }

  group('LoginWithOtp Widget Tests', () {
    testWidgets('shows validation error for empty email/phone field', (tester) async {
      await pumpLoginWithOtpScreen(tester);
      final continueBtn = find.text(AppStrings.continueText);
      await tester.tap(continueBtn);
      await tester.pump();
      expect(find.text(ValidationMessages.emailOrPhoneNumberReq), findsOneWidget);
    });
  });
}
