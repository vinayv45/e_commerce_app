import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> fetchProducts();
  Future<List<String>> getCategories();
  Future<List<ProductEntity>> getProductByCategory(String category);
}
