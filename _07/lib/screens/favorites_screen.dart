import 'package:_07/models/meal.dart';
import 'package:_07/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  static const String routeName = '/';

  const FavoritesScreen({Key? key, required this.favoriteMeals})
      : super(key: key);

  final List<Meal> favoriteMeals;

  Widget _buildEmptyState() {
    return const Center(
      child: Text('You have no favorites yet'),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return _buildEmptyState();
    } else {
      return Center(
        child: ListView.builder(
          itemBuilder: (bContext, index) {
            return MealItem(
              meal: favoriteMeals[index],
            );
          },
          itemCount: favoriteMeals.length,
        ),
      );
    }
  }
}
