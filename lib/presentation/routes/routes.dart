import 'package:flutter/material.dart';
import 'package:password_manager/presentation/screens/login_screen.dart';
import 'package:password_manager/presentation/screens/signup_screen.dart';
import 'package:password_manager/presentation/screens/home_screen.dart';
import 'package:password_manager/presentation/screens/splash_screen.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case '/home':
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case '/login':
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case '/signup':
      return MaterialPageRoute(builder: (_) => SignupScreen());
    default:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
