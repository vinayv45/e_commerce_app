import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';

class FetchCategoriesUseCase {
  final ProductRepository repository;

  FetchCategoriesUseCase(this.repository);

  Future<List<String>> execute() async {
    return await repository.getCategories();
  }
}
