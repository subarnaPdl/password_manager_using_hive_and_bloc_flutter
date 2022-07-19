part of 'signup_bloc.dart';

class SignupState {
  final String password;
  bool get isValidPassword => password.length > 5;

  final String confirmPassword;
  bool get isValidConfirmPassword => password == confirmPassword;

  final FormSubmissionStatus formStatus;

  SignupState({
    this.password = '',
    this.confirmPassword = '',
    this.formStatus = const FormSubmissionStatus(),
  });

  SignupState copyWith({
    String? password,
    String? confirmPassword,
    FormSubmissionStatus? formStatus,
  }) {
    return SignupState(
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        formStatus: formStatus ?? this.formStatus);
  }
}
