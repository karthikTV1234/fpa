import 'package:child_health_story/core/constants/path_constants.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:child_health_story/core/constants/strings/validation_messages.dart';
import 'package:child_health_story/features/auth/presentation/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpSignUpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const SignUpScreen(),
          routes: {
            PathConstants.loginScreen: (context) => const Placeholder(key: Key('loginScreen')),
          },
      ),
    );
  }

  group('SignUpScreen Widget Tests', () {
    testWidgets('shows validation errors for empty fields', (tester) async {
      await pumpSignUpScreen(tester);

      final createAccountButton = find.text(AppStrings.createMyAccountText);
      await tester.tap(createAccountButton);
      await tester.pump();

      expect(find.textContaining('Please enter'), findsWidgets);
    });

    testWidgets('shows validation error for invalid email', (tester) async {
      await pumpSignUpScreen(tester);

      await tester.enterText(find.byType(TextFormField).at(2), 'invalidemail');
      await tester.tap(find.text(AppStrings.createMyAccountText));
      await tester.pump();

      expect(find.text(ValidationMessages.plsEnterValidEmail), findsOneWidget);
    });

    testWidgets('shows validation error for invalid phone number', (tester) async {
      await pumpSignUpScreen(tester);

      await tester.enterText(find.byType(TextFormField).at(3), '1234');
      await tester.tap(find.text(AppStrings.createMyAccountText));
      await tester.pump();

      expect(find.text(ValidationMessages.plsEnterValidPhoneNumber), findsOneWidget);
    });

    testWidgets('shows validation error for weak password', (tester) async {
      await pumpSignUpScreen(tester);

      await tester.enterText(find.byType(TextFormField).at(4), 'weak');
      await tester.tap(find.text(AppStrings.createMyAccountText));
      await tester.pump();

      expect(find.text(ValidationMessages.passwordPolicy), findsOneWidget);
    });

    testWidgets('shows validation error for confirm password mismatch', (tester) async {
      await pumpSignUpScreen(tester);

      await tester.enterText(find.byType(TextFormField).at(4), 'StrongPass@123');
      await tester.enterText(find.byType(TextFormField).at(5), 'DifferentPass@123');
      await tester.tap(find.text(AppStrings.createMyAccountText));
      await tester.pump();

      expect(find.text(ValidationMessages.passwordDoNotMatch), findsOneWidget);
    });

    testWidgets('navigates to loginScreen on valid sign up', (tester) async {
      await pumpSignUpScreen(tester);

      final firstNameField = find.byType(TextFormField).at(0);
      final lastNameField = find.byType(TextFormField).at(1);
      final emailField = find.byType(TextFormField).at(2);
      final phoneField = find.byType(TextFormField).at(3);
      final passwordField = find.byType(TextFormField).at(4);
      final confirmPasswordField = find.byType(TextFormField).at(5);

      await tester.enterText(firstNameField, 'John');
      await tester.enterText(lastNameField, 'Doe');
      await tester.enterText(emailField, 'john.doe@example.com');
      await tester.enterText(phoneField, '1234567890');
      await tester.enterText(passwordField, 'StrongPass@123');
      await tester.enterText(confirmPasswordField, 'StrongPass@123');

      final createAccountButton = find.text(AppStrings.createMyAccountText);
      await tester.tap(createAccountButton);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('loginScreen')), findsOneWidget);
    });
  });
}
