import 'dart:async';

import 'package:flutter/material.dart';
import 'package:password_manager/data/repositories/auth_repository.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {
      if (await _authRepository.isMasterPassCreated) {
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        Navigator.of(context).pushReplacementNamed('/signup');
      }
    });
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(),
      ),
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 64,
          width: 64,
        ),
      ),
    );
  }
}
