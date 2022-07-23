import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/logic/bloc/pass/pass_bloc.dart';
import 'package:password_manager/presentation/screens/addpass_screen.dart';
import 'package:password_manager/presentation/screens/passview_screen.dart';
import 'package:password_manager/presentation/widgets/confirmation_dailog.dart';

class UsersViewScreen extends StatelessWidget {
  final SuperPassModel superPassModel;
  const UsersViewScreen({Key? key, required this.superPassModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _bodyView(),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(superPassModel.title),
      actions: [
        IconButton(
          onPressed: () => deleteTitleConfirmation(
              context: context, title: superPassModel.title),
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  Widget _bodyView() {
    return BlocBuilder<PassBloc, PassState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: superPassModel.passModel.length,
          itemBuilder: (context, index) {
            final pm = superPassModel.passModel[index];
            return ListTile(
              title: Text(pm.username),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PassViewScreen(
                          title: superPassModel.title, passModel: pm),
                    ));
              },
            );
          },
        );
      },
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPassScreen(title: superPassModel.title),
            ));
      },
    );
  }
}
