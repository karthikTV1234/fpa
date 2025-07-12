import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/utils/result.dart';

class FirebaseAuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<Result<String>> requestOtp({
    required String phoneNumber,
  }) async {
    final String formattedNumber = "+91${phoneNumber.trim()}";

    try {
      final completer = Completer<Result<String>>();

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: formattedNumber,
        verificationCompleted: (_) {
          // Optionally handle auto verification
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!completer.isCompleted) {
            if (e.code == 'invalid-phone-number') {
              completer.complete(Result.failure("Invalid phone number. Please check and try again."));
            } else if (e.code == 'too-many-requests') {
              completer.complete(Result.failure("Too many attempts. Please try again later."));
            } else {
              completer.complete(Result.failure("OTP verification failed. Please try again."));
            }
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          if (!completer.isCompleted) {
            completer.complete(Result.success(verificationId));
          }
        },
        codeAutoRetrievalTimeout: (_) {
          // Optionally handle timeout if needed
        },
      );
      return completer.future;
    } catch (e) {
      return Result.failure("Something went wrong. Please try again.");
    }
  }

  Future<Result<void>> submitOtp({
    required String otp,
    required String verificationId,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp.trim(),
      );

      await _firebaseAuth.signInWithCredential(credential);

      return Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(e.message ?? "OTP verification failed. Please try again.");
    } catch (e) {
      return Result.failure("Something went wrong. Please try again.");
    }
  }
}
