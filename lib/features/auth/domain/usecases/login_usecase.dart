import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/firebase_repository.dart';
import 'package:flutter/widgets.dart';

class LoginUseCase {
  final FirebaseRepository firebaseRepository;
  LoginUseCase({required this.firebaseRepository});

  Future<UserEntity?> execute(
      {String? email, String? password, BuildContext? context}) async {
    return await firebaseRepository.loginUsers(
      email: email!,
      password: password!,
      context: context!,
    );
  }
}
