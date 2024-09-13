import 'package:e_commerce_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: AppPallete.gradient1,
        elevation: 0, // Removes the shadow
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ), // Adjust padding as needed
        child: const SizedBox(
          width: 100, // Adjust width as needed
          height: 100, // Adjust height as needed
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
