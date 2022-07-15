part of 'pass_bloc.dart';

@immutable
abstract class PassEvent {}

class PassLoadEvent extends PassEvent {}

class PassAddEvent extends PassEvent {
  final SuperPassModel pass;
  PassAddEvent({required this.pass});
}

class PassUpdateEvent extends PassEvent {
  final SuperPassModel pass;
  final String id;
  PassUpdateEvent({required this.id, required this.pass});
}

class PassDeleteEvent extends PassEvent {
  final String id;
  PassDeleteEvent({required this.id});
}
