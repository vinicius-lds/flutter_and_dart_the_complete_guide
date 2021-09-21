import 'package:_07/models/filters.dart';
import 'package:_07/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';

  const FiltersScreen(
      {Key? key, required this.filters, required this.onSaveFilters})
      : super(key: key);

  final Filters filters;
  final Function onSaveFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _gluttenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    super.initState();
    _gluttenFree = widget.filters.gluttenFree;
    _lactoseFree = widget.filters.lactoseFree;
    _vegan = widget.filters.vegan;
    _vegetarian = widget.filters.vegetarian;
  }

  void _saveFilters() {
    widget.onSaveFilters(
      Filters(
        gluttenFree: _gluttenFree,
        lactoseFree: _lactoseFree,
        vegan: _vegan,
        vegetarian: _vegetarian,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(onPressed: _saveFilters, icon: const Icon(Icons.save)),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  title: const Text('Glutten Free'),
                  subtitle: const Text('Only include glutten-free meals.'),
                  value: _gluttenFree,
                  onChanged: (value) => setState(() => _gluttenFree = value),
                ),
                SwitchListTile(
                  title: const Text('Lactose Free'),
                  subtitle: const Text('Only include lactose-free meals.'),
                  value: _lactoseFree,
                  onChanged: (value) => setState(() => _lactoseFree = value),
                ),
                SwitchListTile(
                  title: const Text('Vegan'),
                  subtitle: const Text('Only include vegan meals.'),
                  value: _vegan,
                  onChanged: (value) => setState(() => _vegan = value),
                ),
                SwitchListTile(
                  title: const Text('Vegetarian'),
                  subtitle: const Text('Only include vegetarian meals.'),
                  value: _vegetarian,
                  onChanged: (value) => setState(() => _vegetarian = value),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
