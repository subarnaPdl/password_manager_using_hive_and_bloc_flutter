part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupPasswordChanged extends SignupEvent {
  final String password;
  SignupPasswordChanged({required this.password});
}

class SignupConfirmPasswordChanged extends SignupEvent {
  final String confirmPassword;
  SignupConfirmPasswordChanged({required this.confirmPassword});
}

class SignupSubmitted extends SignupEvent {}
