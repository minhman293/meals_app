import 'package:flutter/material.dart';
import 'package:meal_app/controllers/filter_meal_controller.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/widgets/bottom_navigation.dart';
import 'package:meal_app/widgets/main_drawer.dart';

const kInitializeFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIdx = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilter = kInitializeFilter;

  void _showMessage(String mess) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mess),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showMessage('Remove from favorite');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showMessage('Add to favorite');
    }
  }

  void _selectPage(int idx) {
    setState(() {
      _selectedPageIdx = idx;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(this);

    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilter,
          ),
        ),
      );
      setState(() {
        _selectedFilter = result ?? kInitializeFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // where() method: create a list of item satisfied conditions
    final filteredMeals =
        FilterMealController().filterMeals(_selectedFilter, dummyMeals);

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: filteredMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIdx == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectedScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigation(
          pageIndex: _selectedPageIdx, selectPage: _selectPage),
    );
  }
}
