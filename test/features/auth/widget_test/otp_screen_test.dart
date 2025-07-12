import 'package:bloc_test/bloc_test.dart';
import 'package:child_health_story/core/constants/path_constants.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:child_health_story/core/constants/strings/validation_messages.dart';
import 'package:child_health_story/features/auth/presentation/bloc/login_otp_bloc.dart';
import 'package:child_health_story/features/auth/presentation/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockAuthBloc extends MockBloc<LoginOtpEvent, LoginOtpState> implements LoginOtpBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  tearDown(() {
    mockAuthBloc.close();
  });

  Future<void> pumpOtpScreen(WidgetTester tester,
      {bool isFromForgotPassword = false}) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          PathConstants.changePasswordScreen: (_) =>
          const Placeholder(key: Key('changePasswordScreen')),
          PathConstants.addchild: (_) =>
          const Placeholder(key: Key('addChildScreen')),
        },
        home: BlocProvider<LoginOtpBloc>.value(
          value: mockAuthBloc,
          child: OtpScreen(
            firebaseVerificationId: 'verification-id',
            isFromForgotPassword: isFromForgotPassword,
          ),
        ),
      ),
    );
  }

  group('OtpScreen Widget Tests', () {
    testWidgets('shows validation error if OTP is not entered', (tester) async {
      when(() => mockAuthBloc.state).thenReturn(LoginOtpInitial());

      await pumpOtpScreen(tester);

      final verifyButton = find.text(AppStrings.verifyMyAccountText);
      await tester.tap(verifyButton);
      await tester.pump();

      expect(find.text(ValidationMessages.plsEnterOTP), findsOneWidget);
    });

    testWidgets('shows error snackbar on API failure', (tester) async {
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([
          LoginOtpLoading(),
          LoginOtpError('OTP verification failed'),
        ]),
        initialState: LoginOtpInitial(),
      );

      await pumpOtpScreen(tester);
      final pinInput = find.byType(EditableText);
      await tester.enterText(pinInput, '123456');
      final verifyButton = find.text(AppStrings.verifyMyAccountText);
      await tester.tap(verifyButton);
      await tester.pump(); // loader
      await tester.pump(); // error snackbar

      expect(find.text('OTP verification failed'), findsOneWidget);
    });

    testWidgets('navigates to addChildScreen on success if not from forgot password',
            (tester) async {
          whenListen(
            mockAuthBloc,
            Stream.fromIterable([
              LoginOtpLoading(),
              LoginOtpSuccess(),
            ]),
            initialState: LoginOtpInitial(),
          );
          await pumpOtpScreen(tester);
          final pinInput = find.byType(EditableText);
          await tester.enterText(pinInput, '123456');
          // Tap the continue button
          final verifyButton = find.text(AppStrings.verifyMyAccountText);
          await tester.tap(verifyButton, warnIfMissed: false);
          await tester.pumpAndSettle();

          expect(find.byKey(const Key('addChildScreen')), findsOneWidget);
        });
  });
}
