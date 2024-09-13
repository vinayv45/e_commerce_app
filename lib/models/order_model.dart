class OrderModel {
  final int? id;
  final String orderNumber;
  final double totalAmount;
  final String paymentType;
  final String shippingAddress;
  final String orderDate;
  final String customerName;

  OrderModel({
    this.id, // Make ID nullable
    required this.orderNumber,
    required this.totalAmount,
    required this.paymentType,
    required this.shippingAddress,
    required this.orderDate,
    required this.customerName,
  });

  // Convert a OrderModel into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id, // This can be null for new entries
      'orderNumber': orderNumber,
      'totalAmount': totalAmount,
      'paymentType': paymentType,
      'shippingAddress': shippingAddress,
      'orderDate': orderDate,
      'customerName': customerName,
    };
  }

  // Convert a Map into a OrderModel.
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'], // ID should be read from map
      orderNumber: map['orderNumber'],
      totalAmount: map['totalAmount'],
      paymentType: map['paymentType'],
      shippingAddress: map['shippingAddress'],
      orderDate: map['orderDate'],
      customerName: map['customerName'],
    );
  }
}
