import 'package:child_health_story/features/auth/model/login_model.dart';
import 'package:child_health_story/features/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

/// EVENTS
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  final String deviceId;
  LoginSubmitted({
    required this.email,
    required this.password,
    required this.deviceId,
  });
  @override
  List<Object?> get props => [email, password, deviceId];
}

/// STATES
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
  @override
  List<Object?> get props => [error];
}

/// BLOC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      final result = await authRepository.login(
        LoginReqModel(
          email: event.email,
          password: event.password,
          deviceId: event.deviceId,
        ),
      );
      if (result.isSuccess) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(result.error ?? "Login failed. Please try again!"));
      }
    });
  }
}
