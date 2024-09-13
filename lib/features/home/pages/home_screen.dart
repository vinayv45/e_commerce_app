import 'package:e_commerce_app/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:e_commerce_app/features/home/viewmodel/home_view_model.dart';
import 'package:e_commerce_app/features/cart/presentation/pages/cart_screen%20.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Welcome'),
            actions: [
              Consumer<CartViewModel>(
                builder: (context, cartViewModel, child) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                    child: Badge(
                      backgroundColor: Colors.red,
                      label: Text(
                        cartViewModel.cartItems.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      child: const Icon(
                        Icons.shopping_cart,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
          body:
              homeViewModel.screen[homeViewModel.currentBottomNavigationIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              homeViewModel.setBottomNavigationIndex(index);
            },
            currentIndex: homeViewModel.currentBottomNavigationIndex,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  Icons.home,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Account',
                icon: Icon(
                  Icons.person,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
