import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:uuid/uuid.dart';

import '../../logic/bloc/pass/pass_bloc.dart';

class AddPassWidget extends StatefulWidget {
  const AddPassWidget({Key? key}) : super(key: key);

  @override
  State<AddPassWidget> createState() => _AddPassWidgetState();
}

class _AddPassWidgetState extends State<AddPassWidget> {
  final TextEditingController _websiteTEC = TextEditingController();
  final TextEditingController _userNameTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  Uuid uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Add Password",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Website Name",
                ),
                controller: _websiteTEC,
              ),
              const SizedBox(height: 10),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
                controller: _userNameTEC,
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PassBloc>().add(PassAddEvent(
                            pass: PassModel(
                              id: uuid.v4(),
                              websiteName: _websiteTEC.text,
                              username: _userNameTEC.text,
                              password: _passwordTEC.text,
                            ),
                          ));
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
