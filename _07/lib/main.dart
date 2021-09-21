import 'package:_07/dummy_data.dart';
import 'package:_07/models/filters.dart';
import 'package:_07/models/meal.dart';
import 'package:_07/screens/categories_screen.dart';
import 'package:_07/screens/category_meals_screen.dart';
import 'package:_07/screens/favorites_screen.dart';
import 'package:_07/screens/filters_screen.dart';
import 'package:_07/screens/meal_detail_screen.dart';
import 'package:_07/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Filters _filters = const Filters();
  List<Meal> _meals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _onSaveFilters(Filters filters) {
    setState(() {
      _filters = filters;
      _meals = dummyMeals
          .where((meal) => !_filters.gluttenFree || meal.isGlutenFree)
          .where((meal) => !_filters.lactoseFree || meal.isLactoseFree)
          .where((meal) => !_filters.vegan || meal.isVegan)
          .where((meal) => !_filters.vegetarian || meal.isVegetarian)
          .toList();
    });
  }

  void _onToggleFavorite(Meal meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals =
            _favoriteMeals.where((item) => item.id != meal.id).toList();
      } else {
        _favoriteMeals = [..._favoriteMeals, meal];
      }
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.pink,
              secondary: Colors.amber,
            ),
      ),
      routes: {
        TabsScreen.routeName: (_) => TabsScreen(favoriteMeals: _favoriteMeals),
        CategoriesScreen.routeName: (_) => const CategoriesScreen(),
        CategoryMealsScreen.routeName: (_) =>
            CategoryMealsScreen(meals: _meals),
        MealDetailScreen.routeName: (_) => MealDetailScreen(
              isFavoriteFn: _isFavorite,
              onToggleFavorite: _onToggleFavorite,
            ),
        FiltersScreen.routeName: (_) => FiltersScreen(
              filters: _filters,
              onSaveFilters: _onSaveFilters,
            ),
      },
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(
      //     builder: (bContext) => const CategoriesScreen(),
      //   );
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (bContext) => const CategoriesScreen(),
        );
      },
    );
  }
}
