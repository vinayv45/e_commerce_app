import 'package:e_commerce_app/core/common/widgets/custom_button.dart';
import 'package:e_commerce_app/core/theme/app_pallete.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => LoginScreen(),
      );
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _loginForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  color: AppPallete.whiteColor,
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value.toString().isEmpty) {
                    return 'Enter Email';
                  }
                  return null;
                },
                controller: _emailController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFormField(
                textInputAction: TextInputAction.done,
                validator: (String? value) {
                  if (value.toString().isEmpty) {
                    return 'Enter Password';
                  }
                  return null;
                },
                controller: _passwordController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomButton(
                buttonText: 'Login',
                onPressed: () {
                  if (_loginForm.currentState!.validate()) {
                    authViewModel.login(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      context,
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, SignUpPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
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
    );
  }
}
