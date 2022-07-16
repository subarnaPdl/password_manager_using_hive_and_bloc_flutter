part of 'pass_bloc.dart';

@immutable
abstract class PassEvent {}

class PassLoadEvent extends PassEvent {}

class PassAddEvent extends PassEvent {
  final String title;
  final PassModel passModel;
  PassAddEvent({
    required this.title,
    required this.passModel,
  });
}

class PassUpdateEvent extends PassEvent {
  final String title;
  final String username;
  final PassModel passModel;
  PassUpdateEvent({
    required this.title,
    required this.username,
    required this.passModel,
  });
}

class PassDeleteEvent extends PassEvent {
  final String title;
  PassDeleteEvent({required this.title});
}
