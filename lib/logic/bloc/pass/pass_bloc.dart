import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/data/repositories/pass_repository.dart';

part 'pass_event.dart';
part 'pass_state.dart';

class PassBloc extends Bloc<PassEvent, PassState> {
  final PassRepository _passRepo;
  PassBloc(this._passRepo) : super(PassInitial()) {
    on<PassLoadEvent>(_passLoadEvent);
    on<PassAddEvent>(_passAddEvent);
    on<PassUpdateEvent>(_passUpdateEvent);
    on<SuperPassDeleteEvent>(_superPassDeleteEvent);
    on<PassDeleteEvent>(_passDeleteEvent);
  }

  Future<void> _passLoadEvent(
      PassLoadEvent event, Emitter<PassState> emit) async {
    await _passRepo.init();
    emit(PassLoadedState(await _passRepo.getData()));
  }

  Future<void> _passAddEvent(
      PassAddEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    _passRepo.saveData(event.title, event.passModel);
    emit(PassLoadedState(await _passRepo.getData()));
  }

  void _passUpdateEvent(PassUpdateEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    _passRepo.updateData(
        title: event.title,
        username: event.username,
        newPassModel: event.passModel);
    emit(PassLoadedState(await _passRepo.getData()));
  }

  void _superPassDeleteEvent(
      SuperPassDeleteEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    _passRepo.deleteData(title: event.title);

    emit(PassLoadedState(await _passRepo.getData()));
  }

  void _passDeleteEvent(PassDeleteEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    _passRepo.deleteData(title: event.title, username: event.username);

    emit(PassLoadedState(await _passRepo.getData()));
  }
}
