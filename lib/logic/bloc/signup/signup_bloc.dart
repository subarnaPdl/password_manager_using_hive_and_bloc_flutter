import 'package:bloc/bloc.dart';
import 'package:password_manager/logic/repo/auth_repository.dart';
import 'package:password_manager/logic/form_login_state.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepo;
  SignupBloc({required this.authRepo}) : super(SignupState()) {
    on<SignupEvent>((event, emit) async {
      // Password update
      if (event is SignupPasswordChanged) {
        emit(state.copyWith(password: event.password));
      }

      // Confirm password update
      else if (event is SignupConfirmPasswordChanged) {
        emit(state.copyWith(confirmPassword: event.confirmPassword));
      }

      // Form submitted
      else if (event is SignupSubmitted) {
        emit(state.copyWith(formStatus: FormSubmitting()));
        try {
          await authRepo.signup(password: state.confirmPassword);
          emit(state.copyWith(formStatus: FormSubmissionSuccess()));
        } catch (e) {
          emit(state.copyWith(formStatus: FormSubmissionFailed(e.toString())));
        }
      }
    });
  }
}
