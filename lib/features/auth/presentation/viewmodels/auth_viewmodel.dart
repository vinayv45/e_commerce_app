// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:e_commerce_app/core/common/widgets/loading_dialog.dart';
import 'package:e_commerce_app/core/constant/utils.dart';
import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _user;
  String errorMessage = '';
  final LoginUseCase loginUseCase;

  UserModel? get user => _user;

  AuthViewModel({required this.loginUseCase});

  Future<void> login(
      String email, String password, BuildContext context) async {
    final overlay = Overlay.of(context);
    final loadingOverlayEntry = OverlayEntry(
      builder: (context) => const Positioned(
        child: LoadingDialog(),
      ),
    );

    try {
      overlay.insert(loadingOverlayEntry);
      UserEntity? user = await loginUseCase.execute(
          email: email, password: password, context: context);
      if (user != null) {
        log(user.uid!);
        log(user.email!);
        Navigator.of(context).pushReplacementNamed('/home');
      }
      notifyListeners();
    } finally {
      loadingOverlayEntry.remove();
    }
  }

  Future<void> register(String email, String password, String firstName,
      String lastName, BuildContext context) async {
    final overlay = Overlay.of(context);
    final loadingOverlayEntry = OverlayEntry(
      builder: (context) => const Positioned(
        child: LoadingDialog(),
      ),
    );

    try {
      overlay.insert(loadingOverlayEntry);

      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
        firstName: firstName,
        lastName: lastName,
      );
      if (userCredential.user != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorMessage = getErrorMessage(e.code);
      if (errorMessage.isNotEmpty) {
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        scaffoldMessenger.hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
      errorMessage = '';
      notifyListeners();
    } finally {
      loadingOverlayEntry.remove();
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _auth.signOut();
      _user = null;
      notifyListeners();
      Navigator.of(context).popAndPushNamed('/login');
    } catch (e) {
      log('Error logging out: $e');
    }
  }
}
