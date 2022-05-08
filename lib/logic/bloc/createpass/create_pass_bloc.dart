import 'package:bloc/bloc.dart';
import 'package:password_manager/logic/form_login_state.dart';
import 'package:password_manager/data/repositories/pass_repository.dart';

part 'create_pass_event.dart';
part 'create_pass_state.dart';

class CreatePassBloc extends Bloc<CreatePassEvent, CreatePassState> {
  final PassRepository passRepo;
  CreatePassBloc({required this.passRepo}) : super(CreatePassState()) {
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
          await passRepo.saveData(
            websiteName: state.websiteName,
            username: state.username,
            password: state.password,
          );
          emit(state.copyWith(formStatus: FormSubmissionSuccess()));
        } catch (e) {
          emit(state.copyWith(formStatus: FormSubmissionFailed(e.toString())));
        }
      }
    });
  }
}
