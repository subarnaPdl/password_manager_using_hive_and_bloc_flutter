part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSignupSuccessState extends AuthState {}

class AuthLoginSuccessState extends AuthState {}

class AuthLoginFailedState extends AuthState {
  final String exception;
  AuthLoginFailedState({required this.exception});
}
