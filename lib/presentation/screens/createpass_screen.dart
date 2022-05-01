import 'package:flutter/material.dart';

class CreatePass extends StatefulWidget {
  const CreatePass({Key? key}) : super(key: key);

  @override
  State<CreatePass> createState() => _CreatePassState();
}

class _CreatePassState extends State<CreatePass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("NepPass")),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 18),
            ),
            const Divider(color: Colors.black54, thickness: 0.8, height: 25),

            //
            const Text(
              "Please register a master password to start using the application. Note that if the master password is lost the stored data cannot be recovered because of the missing sync option. It is strongly recommended that you backup your data at regular intervals.",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 25),

            //
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),

            //
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
              ),
            ),
            const SizedBox(height: 20),

            //
            ElevatedButton(onPressed: () {}, child: const Text("Register")),
          ],
        ),
      ),
    );
  }
}
