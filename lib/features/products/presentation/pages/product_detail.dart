import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Add this dependency to your pubspec.yaml

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: Image.network(
                  product.image ?? '',
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),

              // Product Title
              Text(
                product.title ?? '',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 8),

              // Product Rating
              RatingBar.builder(
                initialRating: product.rating!.rate ?? 0,
                minRating: 1,
                itemSize: 20,
                updateOnDrag: false,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // Handle rating update
                },
              ),
              SizedBox(height: 8),

              // Product Price
              Text(
                '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 16),

              // Product Description
              Text(
                product.description ?? '',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 16),

              // Add to Cart Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final cartViewModel =
                        Provider.of<CartViewModel>(context, listen: false);
                    cartViewModel.addToCart(product, context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
