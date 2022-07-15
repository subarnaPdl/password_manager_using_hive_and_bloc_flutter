import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:password_manager/data/models/pass_model.dart';

class UsersViewScreen extends StatelessWidget {
  final SuperPassModel pass;
  const UsersViewScreen({Key? key, required this.pass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pass.username.length,
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  context.read<PassBloc>().add(PassDeleteEvent(id: pass.id));
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
              )
            ],
          ),
          child: ListTile(
            title: Text(pass.title),
            onTap: () {
              print(pass.id);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PassViewScreen(pass: pass),
                  ));
            },
          ),
        );
      },
    );
  }
}
