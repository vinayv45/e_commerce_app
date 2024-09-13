import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/products/data/datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> fetchProducts() async {
    return await remoteDataSource.fetchProducts();
  }

  @override
  Future<List<String>> getCategories() async {
    return await remoteDataSource.getCategories();
  }

  @override
  Future<List<ProductEntity>> getProductByCategory(String category) async {
    return await remoteDataSource.getProductByCategory(category);
  }
}
