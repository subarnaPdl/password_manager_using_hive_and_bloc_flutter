import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_manager/data/models/trash_pass_model.dart';
import 'package:password_manager/logic/bloc/pass/pass_bloc.dart';
import 'package:password_manager/presentation/widgets/sidemenu.dart';

class TrashScreen extends StatefulWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  List<TrashSuperPassModel> _trashList = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacementNamed('/home');
          return false;
        },
        child: Scaffold(
          appBar: _appBar(),
          body: _bodyView(),
          drawer: const SideMenu(),
        ));
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Trash Bin"),
    );
  }

  Widget _bodyView() {
    return BlocBuilder<PassBloc, PassState>(
      builder: (context, state) {
        if (state is PassInitial) {
          return _loadingView();
        } else if (state is PassLoadedState) {
          _trashList = state.trashList;
          return _trashList.isEmpty
              ? _emptyTrashView()
              : _passListView(_trashList);
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

  Widget _emptyTrashView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/empty.png"),
          const SizedBox(height: 25),
          const Text(
            "Nothing in Trash",
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }

  Widget _passListView(List<TrashSuperPassModel> passList) {
    return ListView.builder(
      itemCount: passList.length,
      itemBuilder: (context, index) {
        TrashSuperPassModel superPassModel = passList[index];
        return ListTile(
          title: Text(superPassModel.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.restore),
                onPressed: () {
                  context.read<PassBloc>().add(PassRecoveryEvent(
                        title: superPassModel.title,
                      ));
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  context.read<PassBloc>().add(TrashSuperPassDeleteEvent(
                        title: superPassModel.title,
                      ));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
