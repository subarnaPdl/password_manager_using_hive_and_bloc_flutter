part of 'create_pass_bloc.dart';

abstract class CreatePassEvent {}

class CreatePassWebsiteChanged extends CreatePassEvent {
  final String websiteName;
  CreatePassWebsiteChanged({required this.websiteName});
}

class CreatePassUsernameChanged extends CreatePassEvent {
  final String username;
  CreatePassUsernameChanged({required this.username});
}

class CreatePassPasswordChanged extends CreatePassEvent {
  final String password;
  CreatePassPasswordChanged({required this.password});
}

class CreatePassSubmitted extends CreatePassEvent {}
