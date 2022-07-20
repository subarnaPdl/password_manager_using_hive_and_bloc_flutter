import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/logic/bloc/auth/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _passTEC = TextEditingController();

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
            _loginForm(context),
          ],
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginFailedState) {
          _showSnackBar(context, state.exception);
        } else {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _passwordField(),
            const SizedBox(height: 20),
            _loginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      controller: _passTEC,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Password",
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final isValidForm = _formKey.currentState!.validate();

        if (isValidForm) {
          context.read<AuthBloc>().add(AuthLoginEvent(password: _passTEC.text));
        }
      },
      child: const Text("Login"),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
