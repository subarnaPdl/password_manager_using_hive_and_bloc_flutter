part of 'pass_bloc.dart';

@immutable
abstract class PassState {}

class PassInitial extends PassState {}

class PassLoadedState extends PassState {
  final List<SuperPassModel> passList;

  PassLoadedState(this.passList);
}
