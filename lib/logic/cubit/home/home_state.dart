part of 'home_cubit.dart';

abstract class HomeState {}

class PassListInitial extends HomeState {}

class PassListLoading extends HomeState {}

class PassListLoadSuccess extends HomeState {
  final List<PassModel> passList;

  PassListLoadSuccess({required this.passList});
}

class PassListLoadFailure extends HomeState {
  final String exception;

  PassListLoadFailure({required this.exception});
}
