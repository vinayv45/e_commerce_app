import 'package:e_commerce_app/models/order_item_model.dart';
import 'package:e_commerce_app/models/order_model.dart';
import 'package:e_commerce_app/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:e_commerce_app/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _shippingAddress = '';
  String _paymentMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    final orderProvider = Provider.of<OrderViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                    return ListTile(
                      title: Text(cartItem.title ?? ''),
                      subtitle: Text(
                          '\$${cartItem.price} x ${cartItem.quantity} = \$${(cartItem.price ?? 0) * cartItem.quantity}'),
                    );
                  },
                ),
              ),
              Divider(),
              SizedBox(height: 8),
              Text(
                'Shipping Address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter your shipping address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _shippingAddress = value!;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Payment Method',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: <String>['Credit Card', 'PayPal', 'Cash on Delivery']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _paymentMethod = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Total: \$${cartProvider.subtotal.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _processCheckout(cartProvider, orderProvider);
                    }
                  },
                  child: Text('Confirm Purchase'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processCheckout(
      CartViewModel cartProvider, OrderViewModel orderProvider) async {
    final order = OrderModel(
      id: null,
      orderNumber: DateTime.now().millisecondsSinceEpoch.toString(),
      totalAmount: cartProvider.subtotal,
      paymentType: _paymentMethod,
      shippingAddress: _shippingAddress,
      orderDate: DateTime.now().toIso8601String(),
      customerName: '',
    );

    try {
      final orderId = await orderProvider.addOrder(order);

      for (final item in cartProvider.cartItems) {
        final orderItem = OrderItemModel(
          id: null,
          orderId: orderId,
          productName: item.title ?? '',
          productPrice: item.price ?? 0,
          quantity: item.quantity,
        );
        await orderProvider.addOrderItem(orderItem);
      }

      await cartProvider.clearCart();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order placed successfully!'),
        ),
      );

      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order failed. Please try again.'),
        ),
      );
      print('Error during checkout: $e'); // Log the error for debugging
    }
  }
}
