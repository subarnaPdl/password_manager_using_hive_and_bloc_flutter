import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/logic/bloc/pass/pass_bloc.dart';
import 'package:password_manager/presentation/utils/copy_to_clipboard.dart';

class PassViewScreen extends StatefulWidget {
  final String title;
  final PassModel passModel;
  const PassViewScreen({Key? key, required this.title, required this.passModel})
      : super(key: key);

  @override
  State<PassViewScreen> createState() => _PassViewScreenState();
}

class _PassViewScreenState extends State<PassViewScreen> {
  final _userNameTEC = TextEditingController();
  final _passwordTEC = TextEditingController();
  final _notesTEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isObscure = true;
  bool _isInitial = true;
  bool _readOnly = true;

  @override
  Widget build(BuildContext context) {
    if (_isInitial) {
      _userNameTEC.text = widget.passModel.username;
      _passwordTEC.text = widget.passModel.password;
      _notesTEC.text = widget.passModel.notes;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _readOnly = false;
              });
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autocorrect: false,
                      readOnly: _readOnly,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                      validator: (_) => _userNameTEC.text.isEmpty
                          ? "Username is required"
                          : null,
                      controller: _userNameTEC,
                    ),
                  ),
                  IconButton(
                    onPressed: () => copyToClipboard(
                        context: context, text: _userNameTEC.text),
                    icon: const Icon(Icons.copy),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              //
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      obscureText: _isObscure,
                      enableSuggestions: false,
                      autocorrect: false,
                      readOnly: _readOnly,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Password",
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                  _isInitial = false;
                                });
                              })),
                      validator: (_) => _passwordTEC.text.isEmpty
                          ? "Password is required"
                          : null,
                      controller: _passwordTEC,
                    ),
                  ),
                  IconButton(
                    onPressed: () => copyToClipboard(
                        context: context, text: _passwordTEC.text),
                    icon: const Icon(Icons.copy),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              //
              TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                readOnly: _readOnly,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  labelText: "Notes",
                ),
                controller: _notesTEC,
              ),
              const SizedBox(height: 20),

              //
              if (!_readOnly)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Back")),
                    ElevatedButton(
                      onPressed: () {
                        final isValidForm = _formKey.currentState!.validate();

                        if (isValidForm) {
                          context.read<PassBloc>().add(PassUpdateEvent(
                                title: widget.title,
                                username: widget.passModel.username,
                                passModel: PassModel(
                                  username: _userNameTEC.text,
                                  password: _passwordTEC.text,
                                  notes: _notesTEC.text,
                                ),
                              ));
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
