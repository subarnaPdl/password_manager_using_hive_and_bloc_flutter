import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/logic/bloc/pass/pass_bloc.dart';
import 'package:password_manager/data/repositories/pass_repository.dart';
import 'package:password_manager/presentation/widgets/sidemenu.dart';
import 'package:password_manager/presentation/widgets/startingtutorial.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey key = GlobalKey();
  final TextEditingController _websiteTEC = TextEditingController();
  final TextEditingController _userNameTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  Uuid uuid = const Uuid();

  @override
  void initState() {
    launchTutorial(context, key);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PassBloc(context.read<PassRepository>())..add(PassLoadEvent()),
      child: Scaffold(
        appBar: _appBar(),
        floatingActionButton: _floattingActionButton(),
        drawer: const SideMenu(),
        body: _bodyView(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Home"),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _bodyView() {
    return BlocBuilder<PassBloc, PassState>(
      builder: (context, state) {
        if (state is PassInitial) {
          return _loadingView();
        } else if (state is PassLoadedState) {
          return state.passList.isEmpty
              ? _emptyPassView()
              : _passListView(state.passList);
        }
        return _loadingView();
      },
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

  Widget _passListView(List<PassModel> passList) {
    return ListView.builder(
      itemCount: passList.length,
      itemBuilder: (context, index) {
        final pass = passList[index];
        return ListTile(title: Text(pass.websiteName));
      },
    );
  }

  Widget _floattingActionButton() {
    return FloatingActionButton(
      key: key,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Form(
            child: Column(
              children: [
                TextFormField(
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Website Name",
                  ),
                  controller: _websiteTEC,
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                  ),
                  controller: _userNameTEC,
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                  controller: _passwordTEC,
                ),
                _createPassViewSubmitButton(),
              ],
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _createPassViewSubmitButton() {
    return BlocBuilder<PassBloc, PassState>(
      builder: (context, state) {
        return ElevatedButton(
            onPressed: () {
              context.read<PassBloc>().add(PassAddEvent(
                      pass: PassModel(
                    id: uuid.v4(),
                    websiteName: _websiteTEC.text,
                    username: _userNameTEC.text,
                    password: _passwordTEC.text,
                  )));
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: const Text('Save Password'));
      },
    );
  }
}
