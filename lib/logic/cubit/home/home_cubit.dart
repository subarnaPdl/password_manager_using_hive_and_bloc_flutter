import 'package:bloc/bloc.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/data/repositories/pass_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _passRepo = PassRepository();

  HomeCubit() : super(PassListLoading());

  void getPassList() async {
    if (state is PassListLoadSuccess == false) {
      emit(PassListLoading());
    }

    try {
      final passList = await _passRepo.getData();
      emit(PassListLoadSuccess(passList: passList));
    } catch (e) {
      emit(PassListLoadFailure(exception: e.toString()));
    }
  }
}
