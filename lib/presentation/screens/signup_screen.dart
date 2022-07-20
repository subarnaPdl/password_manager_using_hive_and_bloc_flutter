import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/logic/bloc/auth/auth_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passTEC = TextEditingController();
  final _confirmPassTEC = TextEditingController();

  String? _validatePass(String pass) {
    if (pass.isEmpty) {
      return "Please set a master password";
    } else if (pass.length < 6) {
      return "Enter atleast 6 characters";
    } else {
      return null;
    }
  }

  String? _validateConfirmPass(String pass, String confirmPass) {
    if (confirmPass != pass) {
      return "Not same as password";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Password Manager"),
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
            _bodyView(context),
          ],
        ),
      ),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _passwordField(),
          const SizedBox(height: 20),
          _confirmPasswordField(),
          const SizedBox(height: 20),
          _loginButton(context),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Password",
      ),
      controller: _passTEC,
      validator: (_) => _validatePass(_passTEC.text),
    );
  }

  Widget _confirmPasswordField() {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Confirm Password",
      ),
      controller: _confirmPassTEC,
      validator: (_) =>
          _validateConfirmPass(_passTEC.text, _confirmPassTEC.text),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final isValidForm = _formKey.currentState!.validate();

        if (isValidForm) {
          context
              .read<AuthBloc>()
              .add(AuthSignupEvent(password: _passTEC.text));
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: const Text("Register"),
    );
  }
}
