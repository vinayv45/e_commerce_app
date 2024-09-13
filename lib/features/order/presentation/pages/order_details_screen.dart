import 'package:e_commerce_app/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch order items when the screen initializes
    Provider.of<OrderViewModel>(context, listen: false)
        .fetchOrderItems(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Consumer<OrderViewModel>(
        builder: (context, provider, child) {
          final orderItems = provider.orderItems;

          if (orderItems.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: orderItems.length,
            itemBuilder: (context, index) {
              final item = orderItems[index];
              return ListTile(
                title: Text(item.productName),
                subtitle:
                    Text('Price: \$${item.productPrice} x ${item.quantity}'),
              );
            },
          );
        },
      ),
    );
  }
}
