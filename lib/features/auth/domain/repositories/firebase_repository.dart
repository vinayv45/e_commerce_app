import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/widgets.dart';

abstract class FirebaseRepository {
  Future<UserEntity?> registerUsers({
    required String fname,
    required String lname,
    required String email,
    required String password,
  });

  Future<UserEntity?> loginUsers(
      {required String email,
      required String password,
      required BuildContext context});
}
