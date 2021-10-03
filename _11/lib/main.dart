import 'package:_11/providers/auth.dart';
import 'package:_11/providers/cart.dart';
import 'package:_11/providers/orders.dart';
import 'package:_11/providers/products.dart';
import 'package:_11/screens/auth_screen.dart';
import 'package:_11/screens/cart_screen.dart';
import 'package:_11/screens/edit_product_screen.dart';
import 'package:_11/screens/orders_screen.dart';
import 'package:_11/screens/product_detail_screen.dart';
import 'package:_11/screens/products_overview_screen.dart';
import 'package:_11/screens/user_products_screen.dart';
import 'package:_11/widgets/splash_screen.dart';
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
          create: (bContext) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (bContext) => Products('', [], ''),
          update: (bContext, auth, previous) => Products(
            auth.token ?? '',
            previous!.items,
            auth.userId ?? '',
          ),
        ),
        ChangeNotifierProvider(
          create: (bContext) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (bContext) => Orders('', [], ''),
          update: (bContext, auth, previous) => Orders(
            auth.token ?? '',
            previous!.orders,
            auth.userId ?? '',
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (bContext, auth, _) {
          return MaterialApp(
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
            home: auth.isAuth
                ? const ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (bContext, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SplashScreen();
                      } else {
                        return const AuthScreen();
                      }
                    },
                  ),
            routes: {
              ProductsOverviewScreen.routeName: (_) =>
                  const ProductsOverviewScreen(),
              ProductDetailScreen.routeName: (_) => const ProductDetailScreen(),
              CartScreen.routeName: (_) => const CartScreen(),
              OrdersScreen.routeName: (_) => const OrdersScreen(),
              UserProductsScreen.routeName: (_) => const UserProductsScreen(),
              EditProductScreen.routeName: (_) => const EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}
