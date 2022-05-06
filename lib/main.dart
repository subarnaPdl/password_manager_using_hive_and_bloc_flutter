import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/logic/repo/auth_repository.dart';
import 'package:password_manager/presentation/routes/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.deepOrange));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MaterialApp(
        title: 'My Pass',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        onGenerateRoute: routes,
        initialRoute: '/',
      ),
    );
  }
}
