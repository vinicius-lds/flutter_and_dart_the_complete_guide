import 'package:_07/models/category.dart';
import 'package:_07/models/meal.dart';
import 'package:_07/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meals';

  const CategoryMealsScreen({Key? key, required this.meals}) : super(key: key);

  final List<Meal> meals;

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  Category? _category;
  List<Meal>? _categoryMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      _category = ModalRoute.of(context)!.settings.arguments as Category;
      _categoryMeals = widget.meals
          // .where((meal) => meal.categories.contains(_category!.id))
          .toList();
      _loadedInitData = true;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  // void _removeMeal(Meal meal) {
  //   setState(() {
  //     _categoryMeals = _categoryMeals!
  //         .where((mategoryMeal) => mategoryMeal.id != meal.id)
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_category!.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (bContext, index) {
            return MealItem(
              meal: _categoryMeals![index],
              // onDelete: _removeMeal,
            );
          },
          itemCount: _categoryMeals!.length,
        ),
      ),
    );
  }
}
