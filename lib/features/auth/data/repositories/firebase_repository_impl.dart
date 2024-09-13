import 'package:e_commerce_app/features/auth/data/datasource/firebase_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/firebase_repository.dart';
import 'package:flutter/widgets.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;
  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<UserEntity?> loginUsers(
      {required String email,
      required String password,
      required BuildContext context}) async {
    return await firebaseRemoteDataSource.loginUsers(
      email: email,
      password: password,
      context: context,
    );
  }

  @override
  Future<UserEntity?> registerUsers(
      {required String fname,
      required String lname,
      required String email,
      required String password}) async {
    return await firebaseRemoteDataSource.registerUsers(
      email: email,
      password: password,
      fname: fname,
      lname: lname,
    );
  }
}
