import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/presentation/screens/passview_screen.dart';

class UsersViewScreen extends StatelessWidget {
  final SuperPassModel superPassModel;
  const UsersViewScreen({Key? key, required this.superPassModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: superPassModel.passModel.length,
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  // context
                  //     .read<PassBloc>()
                  //     .add(PassDeleteEvent(id: superPassModel.id));
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
              )
            ],
          ),
          child: ListTile(
            title: Text(superPassModel.title),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PassViewScreen(superPassModel: superPassModel),
                  ));
            },
          ),
        );
      },
    );
  }
}
