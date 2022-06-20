import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/logic/cubit/home/home_cubit.dart';
import 'package:password_manager/logic/form_login_state.dart';
import 'package:password_manager/data/repositories/pass_repository.dart';
import 'package:uuid/uuid.dart';

part 'create_pass_event.dart';
part 'create_pass_state.dart';

class CreatePassBloc extends Bloc<CreatePassEvent, CreatePassState> {
  final PassRepository _passRepo;

  // final HomeCubit homeCubit;
  // StreamSubscription? streamSubscription;

  CreatePassBloc(this._passRepo) : super(CreatePassState()) {
    // listenToHomeCubit();
    on<CreatePassEvent>((event, emit) async {
      // Website name update
      if (event is CreatePassWebsiteChanged) {
        emit(state.copyWith(websiteName: event.websiteName));
      }

      // Username update
      else if (event is CreatePassUsernameChanged) {
        emit(state.copyWith(username: event.username));
      }

      // Password update
      else if (event is CreatePassPasswordChanged) {
        emit(state.copyWith(password: event.password));
      }

      // Form submitted
      else if (event is CreatePassSubmitted) {
        emit(state.copyWith(formStatus: FormSubmitting()));
        try {
          await _passRepo.init();
          PassModel _newPass = PassModel(
              id: const Uuid().v4(),
              websiteName: state.websiteName,
              username: state.username,
              password: state.password);
          await _passRepo.saveData(_newPass);
          await _passRepo.close();
          emit(state.copyWith(formStatus: FormSubmissionSuccess()));
        } catch (e) {
          await _passRepo.close();
          emit(state.copyWith(formStatus: FormSubmissionFailed(e.toString())));
        }
      }
    });
  }
  // void listenToHomeCubit() {}
}
