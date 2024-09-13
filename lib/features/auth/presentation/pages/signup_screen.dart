// ignore_for_file: library_private_types_in_public_api

import 'package:e_commerce_app/core/common/widgets/custom_button.dart';
import 'package:e_commerce_app/core/theme/app_pallete.dart';
import 'package:e_commerce_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _register = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _register,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Register',
                  style: TextStyle(
                    color: AppPallete.whiteColor,
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter FirstName';
                    }
                    return null;
                  },
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    hintText: 'Enter First Name',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter Last Name';
                    }
                    return null;
                  },
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Enter Last Name',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter Email';
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter Email',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter Password';
                    }
                    if (value.length < 6) {
                      return 'Enter Strong Password';
                    }
                    return null;
                  },
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  buttonText: 'Sign Up',
                  onPressed: () {
                    if (_register.currentState!.validate()) {
                      authViewModel.register(
                        _emailController.value.text,
                        _passwordController.value.text,
                        _firstNameController.value.text,
                        _lastNameController.value.text,
                        context,
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, LoginScreen.route());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have a account ? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: 'Login',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
