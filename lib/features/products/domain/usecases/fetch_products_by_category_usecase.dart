import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';

class FetchProductsByCategoryUseCase {
  final ProductRepository repository;

  FetchProductsByCategoryUseCase(this.repository);

  Future<List<ProductEntity>> execute(String category) async {
    return await repository.getProductByCategory(category);
  }
}
