import 'dart:developer';

import 'package:e_commerce_app/features/products/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/products/domain/usecases/fetch_categories_usecase.dart';
import 'package:e_commerce_app/features/products/domain/usecases/fetch_products_by_category_usecase.dart';
import 'package:e_commerce_app/features/products/domain/usecases/fetch_products_usecase.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  final FetchProductsUseCase fetchProductsUseCase;
  final FetchCategoriesUseCase fetchCategoriesUseCase;
  final FetchProductsByCategoryUseCase fetchProductsByCategoryUseCase;

  List<ProductEntity> _allProducts = [];
  List<ProductEntity> _filteredProducts = [];
  List<String> _categories = [];
  bool _isLoading = false;

  List<ProductEntity> get products => _filteredProducts;
  List<String> get categories => _categories;

  String _singleCategory = "All";
  String get singleCategory => _singleCategory;

  bool get isLoading => _isLoading;

  ProductViewModel({
    required this.fetchProductsUseCase,
    required this.fetchCategoriesUseCase,
    required this.fetchProductsByCategoryUseCase,
  });

  Future<void> initialFetchData() async {
    await fetchProducts();
    await fetchCategories();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allProducts = await fetchProductsUseCase.execute();
      if (_allProducts.isNotEmpty) {
        log('Products fetched successfully: ${_allProducts.length}');
      } else {
        log('No products returned from API.');
      }
      _filteredProducts = _allProducts;
    } catch (e) {
      log("Error fetching products: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await fetchCategoriesUseCase.execute();

      if (_categories.isNotEmpty) {
        log('Categories fetched successfully: ${_categories.length}');
      } else {
        log('No categories returned from API.');
      }
      _categories.insert(0, "All");
    } catch (e) {
      log("Error fetching categories: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterProductsByCategory(String category) {
    log('Filtering products by category: $category');
    _singleCategory = category;
    if (category == "All") {
      _filteredProducts = _allProducts;
    } else {
      print(_allProducts.length);
      _filteredProducts = _allProducts.where((product) {
        return product.category?.toLowerCase() == category.toLowerCase();
      }).toList();
    }
    log('Filtered products count: ${_filteredProducts.length}');
    notifyListeners();
  }
}
