import 'package:e_commerce_app/features/home/pages/main_screen.dart';
import 'package:e_commerce_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentBottomNavigationIndex = 0;

  int get currentBottomNavigationIndex => _currentBottomNavigationIndex;

  setBottomNavigationIndex(int index) {
    _currentBottomNavigationIndex = index;
    notifyListeners();
  }

  final List<Widget> _screens = [
    const MainScreen(),
    const ProfileScreen(),
  ];
  List<Widget> get screen => _screens;
}
