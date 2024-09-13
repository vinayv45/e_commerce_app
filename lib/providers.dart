import 'package:e_commerce_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:e_commerce_app/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:e_commerce_app/features/home/viewmodel/home_view_model.dart';
import 'package:e_commerce_app/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:e_commerce_app/features/products/presentation/viewmodel/product_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider(create: (_) => GetIt.instance<AuthViewModel>()),
    ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ChangeNotifierProvider(create: (_) => CartViewModel()),
    ChangeNotifierProvider(create: (_) => OrderViewModel()),
    ChangeNotifierProvider<ProductViewModel>(
      create: (_) => GetIt.instance<ProductViewModel>()..initialFetchData(),
    ),
  ];
}
