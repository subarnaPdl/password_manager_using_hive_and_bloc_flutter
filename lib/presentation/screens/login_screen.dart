import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/logic/bloc/login/login_bloc.dart';
import 'package:password_manager/logic/form_login_state.dart';
import 'package:password_manager/data/repositories/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("NepPass"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Login", style: TextStyle(fontSize: 18)),
            const Divider(color: Colors.black54, thickness: 0.8, height: 25),
            const Text("Enter your master password to login.",
                style: TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 25),
            BlocProvider(
              create: (context) => LoginBloc(
                authRepo: context.read<AuthRepository>(),
              ),
              child: _loginForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is FormSubmissionFailed) {
          _showSnackBar(context, formStatus.exception);
        } else if (formStatus is FormSubmissionSuccess) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _passwordField(),
            const SizedBox(height: 20),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
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
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                child: const Text("Login"),
              );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
