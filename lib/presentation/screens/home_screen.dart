import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/data/repositories/home_repository.dart';
import 'package:password_manager/logic/bloc/pass/pass_bloc.dart';
import 'package:password_manager/presentation/screens/usersview_screen.dart';
import 'package:password_manager/presentation/utils/search_delegate.dart';
import 'package:password_manager/presentation/widgets/confirmation_dailog.dart';
import 'package:password_manager/presentation/widgets/sidemenu.dart';
import 'package:password_manager/presentation/widgets/startingtutorial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SuperPassModel> _passList = [];
  final _homeRepository = HomeRepository();

  @override
  void initState() {
    launchTutorial();
    super.initState();
  }

  void launchTutorial() async {
    bool isFirstTime = await _homeRepository.isFirstTime;
    if (isFirstTime) {
      _homeRepository.setFirstTimeAsFalse();
      showTutorial(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitAppConfirmation(context),
      child: Scaffold(
        appBar: _appBar(context),
        body: _bodyView(),
        drawer: const SideMenu(),
        floatingActionButton: _floatingActionButton(),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Password Manager",
      ),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
                context: context,
                delegate: CustomSearchDelegate(passList: _passList));
          },
          icon: const Icon(Icons.search),
        )
      ],
    );
  }

  Widget _bodyView() {
    return BlocBuilder<PassBloc, PassState>(
      builder: (context, state) {
        if (state is PassInitial) {
          return _loadingView();
        } else if (state is PassLoadedState) {
          _passList = state.passList;
          return _passList.isEmpty
              ? _emptyPassView()
              : _passListView(_passList);
        }
        return _loadingView();
      },
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => Navigator.of(context).pushNamed('/addPass'),
    );
  }

  Widget _loadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _emptyPassView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/empty.png"),
          const SizedBox(height: 25),
          const Text(
            "No entries found",
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }

  Widget _passListView(List<SuperPassModel> passList) {
    return ListView.builder(
      itemCount: passList.length,
      itemBuilder: (context, index) {
        SuperPassModel superPassModel = passList[index];
        return ListTile(
          title: Text(superPassModel.title),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UsersViewScreen(superPassModel: superPassModel),
                ));
          },
        );
      },
    );
  }
}
