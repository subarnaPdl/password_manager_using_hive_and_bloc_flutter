import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/logic/bloc/createpass/create_pass_bloc.dart';
import 'package:password_manager/logic/cubit/home/home_cubit.dart';
import 'package:password_manager/logic/form_login_state.dart';
import 'package:password_manager/data/repositories/pass_repository.dart';
import 'package:password_manager/presentation/widgets/sidemenu.dart';
import 'package:password_manager/presentation/widgets/startingtutorial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    launchTutorial(context, key);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _floattingActionButton(),
      drawer: const SideMenu(),
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: _bodyView(),
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is PassListInitial) {
          context.read<HomeCubit>().getPassList();
        } else if (state is PassListLoading) {
          return _loadingView();
        } else if (state is PassListLoadSuccess) {
          return state.passList.isEmpty
              ? _emptyPassView()
              : _passListView(state.passList);
        } else if (state is PassListLoadFailure) {
          // context.read<HomeCubit>().close();
          return _exceptionView(state.exception);
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
          builder: (context) => BlocProvider(
            create: (context) => CreatePassBloc(context.read<PassRepository>()),
            child: _createPassView(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _createPassView() {
    return Form(
      child: Column(
        children: [
          _createPassViewWebsiteName(),
          _createPassViewUsername(),
          _createPassViewPassword(),
          _createPassViewSubmitButton(),
        ],
      ),
    );
  }

  Widget _createPassViewWebsiteName() {
    return BlocBuilder<CreatePassBloc, CreatePassState>(
      builder: (context, state) {
        return TextFormField(
          autocorrect: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Website Name",
          ),
          onChanged: (value) => context
              .read<CreatePassBloc>()
              .add(CreatePassWebsiteChanged(websiteName: value)),
        );
      },
    );
  }

  Widget _createPassViewUsername() {
    return BlocBuilder<CreatePassBloc, CreatePassState>(
      builder: (context, state) {
        return TextFormField(
          autocorrect: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Username",
          ),
          onChanged: (value) => context
              .read<CreatePassBloc>()
              .add(CreatePassUsernameChanged(username: value)),
        );
      },
    );
  }

  Widget _createPassViewPassword() {
    return BlocBuilder<CreatePassBloc, CreatePassState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Password",
          ),
          onChanged: (value) => context
              .read<CreatePassBloc>()
              .add(CreatePassPasswordChanged(password: value)),
        );
      },
    );
  }

  Widget _createPassViewSubmitButton() {
    return BlocBuilder<CreatePassBloc, CreatePassState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  context.read<CreatePassBloc>().add(CreatePassSubmitted());
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: const Text('Save Password'));
      },
    );
  }

  Widget _exceptionView(String exception) {
    return Center(child: Text(exception));
  }
}
