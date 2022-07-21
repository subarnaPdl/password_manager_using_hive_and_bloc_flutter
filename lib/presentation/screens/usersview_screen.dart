import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
          onPressed: () => showConfirmationDailog(
            context: context,
            title: 'Delete ${superPassModel.title}',
            content: 'It will delete all the passwords saved under this title.',
            yesAction: () {
              Navigator.pop(context);
              context.read<PassBloc>().add(SuperPassDeleteEvent(
                    title: superPassModel.title,
                  ));
              Navigator.pop(context);
            },
          ),
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
            return Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      context.read<PassBloc>().add(PassDeleteEvent(
                            title: superPassModel.title,
                            username: pm.username,
                          ));
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                  )
                ],
              ),
              child: ListTile(
                title: Text(pm.username),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PassViewScreen(
                            title: superPassModel.title, passModel: pm),
                      ));
                },
              ),
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
