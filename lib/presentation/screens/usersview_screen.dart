import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/logic/bloc/pass/pass_bloc.dart';
import 'package:password_manager/presentation/screens/passview_screen.dart';

class UsersViewScreen extends StatelessWidget {
  final SuperPassModel superPassModel;
  const UsersViewScreen({Key? key, required this.superPassModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(superPassModel.title),
      ),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return BlocBuilder<PassBloc, PassState>(
      builder: (context, state) {
        return _usernameView();
      },
    );
  }

  Widget _usernameView() {
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
  }
}
