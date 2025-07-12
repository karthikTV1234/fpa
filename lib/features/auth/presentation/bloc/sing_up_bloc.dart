import 'package:child_health_story/features/auth/model/sing_up_model.dart';
import 'package:child_health_story/features/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class RegisterSubmitted extends SignUpEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String deviceId;

  RegisterSubmitted({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.deviceId,
  });

  @override
  List<Object?> get props =>
      [firstName, lastName, email, phone, password, deviceId];
}

// States
abstract class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}
class RegisterInitial extends SignUpState {}
class RegisterLoading extends SignUpState {}
class RegisterSuccess extends SignUpState {
  final String message;
  RegisterSuccess({required this.message});
  @override
  List<Object> get props => [message];
}
class RegisterFailure extends SignUpState {
  final String error;
  RegisterFailure(this.error);
  @override
  List<Object?> get props => [error];
}

// Bloc
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());

      final result = await authRepository.register(
        SignUpReqModel(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          phone: event.phone,
          password: event.password,
          deviceId: event.deviceId,
        ),
      );
      if (result.isSuccess) {
        final signUpRes = result.data!;
        emit(RegisterSuccess(message: signUpRes.message));
        // If you need to save token:
        // await tokenStorage.saveToken(signUpRes.token);
      } else {
        emit(RegisterFailure(result.error ?? "Registration failed. Please try again!"));
      }
    });
  }
}