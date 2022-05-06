import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/logic/bloc/signup/signup_bloc.dart';
import 'package:password_manager/logic/form_login_state.dart';
import 'package:password_manager/logic/repo/auth_repository.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

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
            const Text("Welcome", style: TextStyle(fontSize: 18)),
            const Divider(color: Colors.black54, thickness: 0.8, height: 25),
            const Text(
                "Please register a master password to start using the application. Note that if the master password is lost the stored data cannot be recovered because of the missing sync option. It is strongly recommended that you backup your data at regular intervals.",
                style: TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 25),
            BlocProvider(
              create: (context) => SignupBloc(
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
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is FormSubmissionFailed) {
          _showSnackBar(context, formStatus.exception);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _passwordField(),
            const SizedBox(height: 20),
            _confirmPasswordField(),
            const SizedBox(height: 20),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Password",
          ),
          validator: (value) =>
              state.isValidPassword ? null : "Password is too short",
          onChanged: (value) => context
              .read<SignupBloc>()
              .add(SignupPasswordChanged(password: value)),
        );
      },
    );
  }

  Widget _confirmPasswordField() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Confirm Password",
          ),
          validator: (value) =>
              state.isValidConfirmPassword ? null : "Not same as password",
          onChanged: (value) => context
              .read<SignupBloc>()
              .add(SignupConfirmPasswordChanged(confirmPassword: value)),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignupBloc>().add(SignupSubmitted());
                  }
                },
                child: const Text("Register"),
              );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
