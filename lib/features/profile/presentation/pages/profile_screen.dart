import 'package:e_commerce_app/core/helper/database.dart';
import 'package:e_commerce_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:e_commerce_app/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:e_commerce_app/features/order/presentation/pages/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const OrdersScreen(),
              ),
            );
          },
          title: const Text('Orders'),
        ),
        ListTile(
          onTap: () async {
            context.read<AuthViewModel>().logout(context);
            context.read<CartViewModel>().clearCart();
            final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
            await _databaseHelper.deleteAllTables();
          },
          title: const Text('Logout'),
        )
      ],
    );
  }
}
