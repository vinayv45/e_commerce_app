import 'package:e_commerce_app/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:e_commerce_app/features/order/presentation/pages/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Consumer<OrderViewModel>(
        builder: (context, orderViewModel, child) {
          return FutureBuilder(
            future: orderViewModel.fetchOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final orders = orderViewModel.orders;
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return ListTile(
                      title: Text(order.orderNumber),
                      subtitle: Text(
                          'Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderDetailsScreen(orderId: order.id!),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
