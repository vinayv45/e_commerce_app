import 'package:e_commerce_app/features/auth/data/datasource/firebase_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/data/repositories/firebase_repository_impl.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/firebase_repository.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:e_commerce_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:e_commerce_app/features/products/presentation/viewmodel/product_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/products/domain/usecases/fetch_products_usecase.dart';
import 'package:e_commerce_app/features/products/domain/usecases/fetch_categories_usecase.dart';
import 'package:e_commerce_app/features/products/domain/usecases/fetch_products_by_category_usecase.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register Http Client
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Register Remote Data Source
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: getIt<http.Client>()),
  );

  getIt.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl(auth: getIt<FirebaseAuth>()));

  // Register Repository
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
        remoteDataSource: getIt<ProductRemoteDataSource>()),
  );

  getIt.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositoryImpl(
      firebaseRemoteDataSource: getIt<FirebaseRemoteDataSource>()));

  // Register Use Cases
  getIt.registerLazySingleton<FetchProductsUseCase>(
    () => FetchProductsUseCase(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<FetchCategoriesUseCase>(
    () => FetchCategoriesUseCase(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<FetchProductsByCategoryUseCase>(
    () => FetchProductsByCategoryUseCase(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(firebaseRepository: getIt<FirebaseRepository>()),
  );

  // Register ViewModel
  getIt.registerFactory<ProductViewModel>(
    () => ProductViewModel(
      fetchProductsUseCase: getIt<FetchProductsUseCase>(),
      fetchCategoriesUseCase: getIt<FetchCategoriesUseCase>(),
      fetchProductsByCategoryUseCase: getIt<FetchProductsByCategoryUseCase>(),
    ),
  );

  getIt.registerFactory<AuthViewModel>(
    () => AuthViewModel(loginUseCase: getIt<LoginUseCase>()),
  );
}
