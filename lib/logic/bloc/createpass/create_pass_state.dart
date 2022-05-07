part of 'create_pass_bloc.dart';

class CreatePassState {
  final String websiteName;
  final String password;
  final String username;
  final FormSubmissionStatus formStatus;

  CreatePassState({
    this.websiteName = '',
    this.password = '',
    this.username = '',
    this.formStatus = const FormSubmissionStatus(),
  });

  CreatePassState copyWith({
    String? websiteName,
    String? password,
    String? username,
    FormSubmissionStatus? formStatus,
  }) {
    return CreatePassState(
        websiteName: websiteName ?? this.websiteName,
        password: password ?? this.password,
        username: username ?? this.username,
        formStatus: formStatus ?? this.formStatus);
  }
}
