import 'package:bloc/bloc.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/data/repositories/pass_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // final CreatePassBloc createPassBloc;
  // StreamSubscription? _streamSubscription;

  final _passRepo = PassRepository();

  // HomeCubit({required this.createPassBloc}) : super(PassListInitial()) {
  HomeCubit() : super(PassListInitial()) {
    // listenToCreatePassBloc();
  }

  void getPassList() async {
    if (state is PassListLoadSuccess == false) {
      emit(PassListLoading());
    }

    try {
      await _passRepo.init();
      final passList = await _passRepo.getData();
      emit(PassListLoadSuccess(passList: passList));
      await _passRepo.close();
    } catch (e) {
      await _passRepo.close();
      emit(PassListLoadFailure(exception: e.toString()));
    }
  }

  // void listenToCreatePassBloc() {
  //   _streamSubscription = createPassBloc.stream.listen((state) {
  //     if (state is CreatePassSubmitted) {
  //       emit(PassListInitial());
  //       // getPassList();
  //     }
  //   });
  // }

  // @override
  // Future<void> close() {
  //   _streamSubscription?.cancel();
  //   return super.close();
  // }
}
