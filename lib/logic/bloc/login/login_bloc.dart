import 'package:bloc/bloc.dart';
import 'package:password_manager/logic/repo/auth_repository.dart';
import 'package:password_manager/logic/form_login_state.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  LoginBloc({required this.authRepo}) : super(LoginState()) {
    on<LoginEvent>((event, emit) async {
      // Password update
      if (event is LoginPasswordChanged) {
        emit(state.copyWith(password: event.password));
      }
      // Form submitted
      else if (event is LoginSubmitted) {
        emit(state.copyWith(formStatus: FormSubmitting()));

        try {
          if (await authRepo.login(password: state.password)) {
            emit(state.copyWith(formStatus: FormSubmissionSuccess()));
          }
        } catch (e) {
          emit(state.copyWith(formStatus: FormSubmissionFailed(e.toString())));
        }
      }
    });
  }
}
