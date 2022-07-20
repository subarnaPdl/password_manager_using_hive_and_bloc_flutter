part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthSignupEvent extends AuthEvent {
  final String password;
  AuthSignupEvent({required this.password});
}

class AuthLoginEvent extends AuthEvent {
  final String password;
  AuthLoginEvent({required this.password});
}
