import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/data/repositories/auth_repository.dart';
import 'package:password_manager/data/repositories/pass_repository.dart';
import 'package:password_manager/logic/bloc_observer.dart';
import 'package:password_manager/presentation/routes/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await Hive.initFlutter();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.deepOrange));

  // To look at the current state info
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => PassRepository(),
        ),
      ],
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
