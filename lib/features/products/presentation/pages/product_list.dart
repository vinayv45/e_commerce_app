import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:e_commerce_app/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:e_commerce_app/features/products/presentation/viewmodel/product_view_model.dart';
import 'package:e_commerce_app/features/products/presentation/pages/product_detail.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shimmer/shimmer.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ResponsiveGridList(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              desiredItemWidth: 150,
              minSpacing: 10,
              children: List.generate(6, (index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[700]!,
                  child: Card(
                    color: Colors.grey[300],
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              height: 150,
                              color: Colors.grey[850],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 20,
                            color: Colors.grey[850],
                          ),
                          const SizedBox(height: 4.0),
                          Container(
                            height: 20,
                            width: 60,
                            color: Colors.grey[850],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 35,
                            width: double.infinity,
                            color: Colors.grey[850],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }

        if (viewModel.products.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ResponsiveGridList(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            desiredItemWidth: 150,
            minSpacing: 10,
            children: List.generate(viewModel.products.length, (index) {
              final product = viewModel.products[index];
              return Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProductDetailsScreen(
                                product: product,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            product.image!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        product.title!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '\$${product.price!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final cartViewModel = GetIt.instance<CartViewModel>();
                          cartViewModel.addToCart(product, context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Center(
                          child: Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
