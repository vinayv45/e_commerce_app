class OrderItemModel {
  final int? id;
  final int orderId;
  final String productName;
  final double productPrice;
  final int quantity;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
  });

  // Convert an OrderItemModel into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
    };
  }

  // Extract an OrderItemModel from a Map object
  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'],
      orderId: map['orderId'],
      productName: map['productName'],
      productPrice: map['productPrice'],
      quantity: map['quantity'],
    );
  }
}
