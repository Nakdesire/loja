import 'package:flutter/material.dart';
import 'package:newapp/pages/auth_page.dart';
import 'package:newapp/pages/orders_page.dart';
import 'package:newapp/pages/product_form_page.dart';
import 'package:newapp/pages/products_page.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/order_list.dart';
import '../models/product_list.dart';
import '../pages/cart_page.dart';
import '../pages/product_detail_page.dart';
import '../pages/products_overview_page.dart';
import '../utils/app_routes.dart';
import 'models/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.auth: (ctx) => const AuthPage(),
          AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          AppRoutes.cart: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) => const OrdersPage(),
          AppRoutes.products: (ctx) => const ProductsPage(),
          AppRoutes.productForm: (ctx) => const ProductFormPage(),
          AppRoutes.productOverview: (ctx) => const ProductsOverviewPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
