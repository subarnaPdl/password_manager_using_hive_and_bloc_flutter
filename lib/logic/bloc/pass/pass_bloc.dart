import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/data/models/trash_pass_model.dart';
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
    on<TrashSuperPassDeleteEvent>(_trashSuperPassDeleteEvent);
    on<PassRecoveryEvent>(_passRecoveryEvent);
  }

  Future<void> _passLoadEvent(
      PassLoadEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    await _passRepo.init();
    await _emitPassLoadedState(emit);
  }

  Future<void> _passAddEvent(
      PassAddEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    await _passRepo.saveData(event.title, event.passModel);
    await _emitPassLoadedState(emit);
  }

  void _passUpdateEvent(PassUpdateEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    await _passRepo.updateData(
        title: event.title,
        username: event.username,
        newPassModel: event.passModel);
    await _emitPassLoadedState(emit);
  }

  void _superPassDeleteEvent(
      SuperPassDeleteEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    await _passRepo.deleteData(title: event.title);
    await _emitPassLoadedState(emit);
  }

  void _passDeleteEvent(PassDeleteEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    await _passRepo.deleteData(title: event.title, username: event.username);
    await _emitPassLoadedState(emit);
  }

  void _trashSuperPassDeleteEvent(
      TrashSuperPassDeleteEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    await _passRepo.deleteTrashData(title: event.title);
    await _emitPassLoadedState(emit);
  }

  void _passRecoveryEvent(
      PassRecoveryEvent event, Emitter<PassState> emit) async {
    emit(PassInitial());
    await _passRepo.recoverData(title: event.title);
    await _emitPassLoadedState(emit);
  }

  Future<void> _emitPassLoadedState(Emitter<PassState> emit) async {
    emit(PassLoadedState(
        passList: await _passRepo.getData(),
        trashList: await _passRepo.getTrashData()));
  }
}
