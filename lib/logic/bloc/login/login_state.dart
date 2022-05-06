part of 'login_bloc.dart';

class LoginState {
  final String password;
  bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.password = '',
    this.formStatus = const FormSubmissionStatus(),
  });

  // Following operation is done so that when only password is entered, we don't have to go back and take the formstatus or viceversa. Also it prevents the creation of multiple classs objects.

  LoginState copyWith({
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
