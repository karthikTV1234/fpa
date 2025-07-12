import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repository/firebase_auth_repository.dart';

//Events
abstract class LoginOtpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthRequestOtp extends LoginOtpEvent {
  final String phoneNumber;
  AuthRequestOtp(this.phoneNumber);
  @override
  List<Object> get props => [phoneNumber];
}

class AuthSubmitOtp extends LoginOtpEvent {
  final String otp;
  final String verificationId;
  AuthSubmitOtp({required this.otp, required this.verificationId});
  @override
  List<Object> get props => [otp, verificationId];
}

//States
abstract class LoginOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginOtpInitial extends LoginOtpState {}
class LoginOtpLoading extends LoginOtpState {}
class LoginOtpSuccess extends LoginOtpState {}
class LoginOtpError extends LoginOtpState {
  final String message;
  LoginOtpError(this.message);
  @override
  List<Object?> get props => [message];
}

class OtpSent extends LoginOtpState {
  final String verificationId;
  OtpSent({required this.verificationId});
  @override
  List<Object?> get props => [verificationId];
}

// Bloc
class LoginOtpBloc extends Bloc<LoginOtpEvent, LoginOtpState> {
  final FirebaseAuthRepository authRepository;

  LoginOtpBloc({required this.authRepository}) : super(LoginOtpInitial()) {
    on<AuthRequestOtp>((event, emit) async {
      emit(LoginOtpLoading());
      final result = await authRepository.requestOtp(phoneNumber: event.phoneNumber);
      if (result.isSuccess) {
        emit(OtpSent(verificationId: result.data!));
      } else {
        emit(LoginOtpError(result.error!));
      }
    });

    on<AuthSubmitOtp>((event, emit) async {
      emit(LoginOtpLoading());
      final result = await authRepository.submitOtp(
        otp: event.otp,
        verificationId: event.verificationId,
      );

      if (result.isSuccess) {
        emit(LoginOtpSuccess());
      } else {
        emit(LoginOtpError(result.error!));
      }
    });
  }
}

