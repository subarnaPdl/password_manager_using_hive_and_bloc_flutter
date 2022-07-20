import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:password_manager/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;
  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<AuthSignupEvent>((event, emit) async {
      authRepo.signup(password: event.password);
      emit(AuthSignupSuccessState());
    });
    on<AuthLoginEvent>((event, emit) async {
      if (await authRepo.login(password: event.password)) {
        emit(AuthLoginSuccessState());
      } else {
        emit(AuthLoginFailedState(exception: "Password Incorrect"));
      }
    });
  }
}
