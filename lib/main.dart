import 'package:e_commerce_app/core/theme/theme.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/init.dart';
import 'package:e_commerce_app/routes.dart';
import 'package:e_commerce_app/providers.dart';
import 'package:e_commerce_app/features/home/pages/home_screen.dart';
import 'package:e_commerce_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getProviders(),
      child: MaterialApp(
        title: 'E-commerce',
        theme: AppTheme.darkThemeMode,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: getAppRoutes(),
      ),
    );
  }
}
