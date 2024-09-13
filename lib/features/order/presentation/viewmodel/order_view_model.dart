import 'package:flutter/foundation.dart';
import 'package:e_commerce_app/core/helper/database.dart';
import 'package:e_commerce_app/models/order_model.dart';
import 'package:e_commerce_app/models/order_item_model.dart';

class OrderViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<OrderModel> _orders = [];
  List<OrderItemModel> _orderItems = [];

  List<OrderModel> get orders => _orders;
  List<OrderItemModel> get orderItems => _orderItems;

  Future<void> fetchOrders() async {
    _orders = await _dbHelper.queryAllOrders();
    notifyListeners();
  }

  Future<void> fetchOrderItems(int orderId) async {
    _orderItems = await _dbHelper.queryOrderItems(orderId);
    notifyListeners();
  }

  Future<int> addOrder(OrderModel order) async {
    final orderId = await _dbHelper.insertOrder(order);

    await fetchOrders();

    return orderId;
  }

  Future<void> addOrderItem(OrderItemModel orderItem) async {
    await _dbHelper.insertOrderItem(orderItem);
    await fetchOrderItems(orderItem.orderId);
  }
}
