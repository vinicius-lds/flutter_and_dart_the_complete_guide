import 'package:_09/providers/cart.dart';
import 'package:_09/providers/orders.dart';
import 'package:_09/providers/products.dart';
import 'package:_09/screens/cart_screen.dart';
import 'package:_09/screens/edit_product_screen.dart';
import 'package:_09/screens/orders_screen.dart';
import 'package:_09/screens/product_detail_screen.dart';
import 'package:_09/screens/products_overview_screen.dart';
import 'package:_09/screens/user_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          create: (bContext) => Products(),
        ),
        ChangeNotifierProvider(
          create: (bContext) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (bContext) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ThemeData.light().colorScheme.copyWith(
                primary: Colors.purple,
                secondary: Colors.deepOrange,
              ),
          fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: ThemeData.light()
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
        ),
        // home: ProductsOverviewScreen(),
        routes: {
          ProductsOverviewScreen.routeName: (_) =>
              const ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (_) => const ProductDetailScreen(),
          CartScreen.routeName: (_) => const CartScreen(),
          OrdersScreen.routeName: (_) => const OrdersScreen(),
          UserProductsScreen.routeName: (_) => const UserProductsScreen(),
          EditProductScreen.routeName: (_) => const EditProductScreen(),
        },
      ),
    );
  }
}
