import 'package:bloc_test/bloc_test.dart';
import 'package:child_health_story/core/utils/result.dart';
import 'package:child_health_story/features/auth/presentation/bloc/login_otp_bloc.dart';
import 'package:child_health_story/features/auth/repository/firebase_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FirebaseAuthRepository {}

void main() {
  late LoginOtpBloc authBloc;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = LoginOtpBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc Tests', () {
    const testPhoneNumber = '9876543210';
    const testOtp = '123456';
    const testVerificationId = 'verification-id';

    test('initial state is AuthInitial', () {
      expect(authBloc.state, LoginOtpInitial());
    });

    blocTest<LoginOtpBloc, LoginOtpState>(
      'emits [AuthLoading, OtpSent] when AuthRequestOtp succeeds',
      build: () {
        when(() => mockAuthRepository.requestOtp(
          phoneNumber: any(named: 'phoneNumber'),
        )).thenAnswer((_) async => Result.success(testVerificationId));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthRequestOtp(testPhoneNumber)),
      expect: () => [
        LoginOtpLoading(),
        OtpSent(verificationId: testVerificationId),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.requestOtp(
          phoneNumber: testPhoneNumber,
        )).called(1);
      },
    );

    blocTest<LoginOtpBloc, LoginOtpState>(
      'emits [AuthLoading, AuthError] when AuthRequestOtp fails',
      build: () {
        when(() => mockAuthRepository.requestOtp(
          phoneNumber: any(named: 'phoneNumber'),
        )).thenAnswer((_) async => Result.failure('Failed to request OTP'));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthRequestOtp(testPhoneNumber)),
      expect: () => [
        LoginOtpLoading(),
        LoginOtpError('Failed to request OTP'),
      ],
    );

    blocTest<LoginOtpBloc, LoginOtpState>(
      'emits [AuthLoading, AuthSuccess] when AuthSubmitOtp succeeds',
      build: () {
        when(() => mockAuthRepository.submitOtp(
          otp: any(named: 'otp'),
          verificationId: any(named: 'verificationId'),
        )).thenAnswer((_) async => Result.success(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSubmitOtp(
        otp: testOtp,
        verificationId: testVerificationId,
      )),
      expect: () => [
        LoginOtpLoading(),
        LoginOtpSuccess(),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.submitOtp(
          otp: testOtp,
          verificationId: testVerificationId,
        )).called(1);
      },
    );

    blocTest<LoginOtpBloc, LoginOtpState>(
      'emits [AuthLoading, AuthError] when AuthSubmitOtp fails',
      build: () {
        when(() => mockAuthRepository.submitOtp(
          otp: any(named: 'otp'),
          verificationId: any(named: 'verificationId'),
        )).thenAnswer((_) async => Result.failure('OTP verification failed'));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSubmitOtp(
        otp: testOtp,
        verificationId: testVerificationId,
      )),
      expect: () => [
        LoginOtpLoading(),
        LoginOtpError('OTP verification failed'),
      ],
    );
  });
}
