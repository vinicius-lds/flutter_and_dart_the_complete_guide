import 'package:_08/providers/products.dart';
import 'package:_08/screens/product_detail_screen.dart';
import 'package:_08/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (bContext) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ThemeData.light().colorScheme.copyWith(
                primary: Colors.purple,
                secondary: Colors.deepOrange,
              ),
          fontFamily: 'Lato',
        ),
        // home: ProductsOverviewScreen(),
        routes: {
          ProductsOverviewScreen.routeName: (_) =>
              const ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (_) => const ProductDetailScreen(),
        },
      ),
    );
  }
}
