import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacementNamed('/signup'));
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo64.png"),
      ),
    );
  }
}
