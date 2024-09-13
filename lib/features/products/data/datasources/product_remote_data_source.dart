import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/core/constant/api_url.dart';
import 'package:e_commerce_app/features/products/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<List<String>> getCategories();
  Future<List<ProductModel>> getProductByCategory(String category);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final response = await client.get(Uri.parse(ApiUrl.getAllProducts));
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await client.get(Uri.parse(ApiUrl.categories));
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);

      return body.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Future<List<ProductModel>> getProductByCategory(String category) async {
    final String url = "${ApiUrl.getProductByCateogory}$category";
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }
}
