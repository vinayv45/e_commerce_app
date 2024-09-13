class CartItemModel {
  int? id;
  String? title;
  double? price;
  int quantity;
  String? image;

  CartItemModel({
    this.id,
    this.title,
    this.price,
    this.image,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }

  // Optionally, add fromMap method for retrieving data from database
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      quantity: map['quantity'],
      image: map['image'],
    );
  }
}
