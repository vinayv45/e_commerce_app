// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';
import 'package:e_commerce_app/core/helper/database.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => _cartItems;

  CartViewModel() {
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    _cartItems = await _databaseHelper.queryAllCartItems();
    notifyListeners();
  }

  Future<void> addToCart(ProductEntity product, BuildContext context) async {
    final existingItem = _cartItems.firstWhere(
      (item) => item.id == product.id,
      orElse: () => CartItemModel(
        id: product.id,
        title: product.title,
        price: product.price,
        image: product.image,
        quantity: 0,
      ),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++;
      await _databaseHelper.updateCartItem(existingItem);
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item updated in cart'),
        ),
      );
    } else {
      final newItem = CartItemModel(
        id: product.id,
        title: product.title,
        price: product.price,
        image: product.image,
        quantity: 1,
      );
      await _databaseHelper.insertCartItem(newItem);
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added to cart'),
        ),
      );
    }

    _loadCartItems();
  }

  Future<void> removeFromCart(int productId) async {
    _cartItems.removeWhere((item) => item.id == productId);
    await _databaseHelper.deleteCartItem(productId);
    notifyListeners();
  }

  Future<void> updateCartItem(CartItemModel item) async {
    await _databaseHelper.updateCartItem(item);
    _loadCartItems();
  }

  double get subtotal {
    double total = 0.0;
    for (var item in _cartItems) {
      total += (item.price ?? 0) * item.quantity;
    }
    return total;
  }

  Future<void> clearCart() async {
    for (var item in _cartItems) {
      await _databaseHelper.deleteCartItem(item.id!);
    }
    _cartItems.clear();
    notifyListeners();
  }
}
