import 'package:_07/models/meal.dart';
import 'package:_07/screens/categories_screen.dart';
import 'package:_07/screens/favorites_screen.dart';
import 'package:_07/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/';

  const TabsScreen({Key? key, required this.favoriteMeals}) : super(key: key);

  final List<Meal> favoriteMeals;

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget>? _pages;
  List<String>? _titles;
  int? _selectedPageIndex;

  @override
  void initState() {
    super.initState();
    _pages = [
      const CategoriesScreen(),
      FavoritesScreen(favoriteMeals: widget.favoriteMeals),
    ];
    _titles = [
      'Categories',
      'Your Favorites',
    ];
    _selectedPageIndex = 0;
  }

  void _selectPage(int index) {
    setState(() => _selectedPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Meals'),
    //       bottom: const TabBar(
    //         tabs: [
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: 'Categories',
    //           ),
    //           Tab(
    //             icon: Icon(Icons.star),
    //             text: 'Favorites',
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: const TabBarView(
    //       children: [
    //         CategoriesScreen(),
    //         FavoritesScreen(),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles![_selectedPageIndex!]),
      ),
      drawer: const MainDrawer(),
      body: _pages![_selectedPageIndex!],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex!,
        type: BottomNavigationBarType.shifting,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.category),
            label: 'Categories',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: 'Favorites',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
