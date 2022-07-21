part of 'pass_bloc.dart';

@immutable
abstract class PassState {}

class PassInitial extends PassState {}

class PassLoadedState extends PassState {
  final List<SuperPassModel> passList;
  final List<TrashSuperPassModel> trashList;

  PassLoadedState({required this.passList, required this.trashList});
}
