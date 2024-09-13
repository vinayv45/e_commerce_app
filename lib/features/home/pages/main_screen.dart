import 'package:e_commerce_app/features/products/presentation/pages/category_list.dart';
import 'package:e_commerce_app/features/products/presentation/pages/product_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: size.height * 0.1,
            child: const CategoryList(),
          ),
          const Expanded(
            child: ProductList(),
          ),
        ],
      ),
    );
  }
}
