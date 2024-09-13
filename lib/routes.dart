import 'package:e_commerce_app/features/home/pages/home_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/login_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:e_commerce_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/login': (context) => LoginScreen(),
    '/home': (context) => const HomeScreen(),
    '/register': (context) => const SignUpPage(),
  };
}

Widget getInitialRoute() {
  return const SplashScreen();
}
