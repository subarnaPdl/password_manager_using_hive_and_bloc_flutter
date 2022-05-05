import 'package:flutter/material.dart';
import 'package:password_manager/presentation/screens/addpass_screen.dart';
import 'package:password_manager/presentation/screens/auth_screen.dart';
import 'package:password_manager/presentation/screens/home_screen.dart';
import 'package:password_manager/presentation/screens/splash_screen.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case '/home':
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case '/auth':
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case '/add':
      return MaterialPageRoute(builder: (_) => const AddPassScreen());
    default:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
