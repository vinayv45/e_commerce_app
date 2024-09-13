// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:e_commerce_app/core/constant/utils.dart';
import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class FirebaseRemoteDataSource {
  Future<UserModel?> registerUsers({
    required String fname,
    required String lname,
    required String email,
    required String password,
  });

  Future<UserModel?> loginUsers(
      {required String email,
      required String password,
      required BuildContext context});
}

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;

  FirebaseRemoteDataSourceImpl({required this.auth});

  @override
  Future<UserModel?> loginUsers({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel(email: email, uid: userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      log("Error during login: ${e.message}");
      String errorMessage = getErrorMessage(e.code);
      if (errorMessage.isNotEmpty) {
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        scaffoldMessenger.hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
        errorMessage = '';
      }

      return null;
    } catch (e) {
      log("Unexpected error during login: $e");
      return null;
    }
  }

  @override
  Future<UserModel?> registerUsers({
    required String fname,
    required String lname,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName('$fname $lname');

      return UserModel(email: email, uid: userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      log("Error during registration: ${e.message}");
      return null;
    } catch (e) {
      log("Unexpected error during registration: $e");
      return null;
    }
  }
}
