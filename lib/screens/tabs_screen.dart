import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meal_app/controllers/filter_meal_controller.dart';
import 'package:meal_app/providers/favorites_provider.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/widgets/bottom_navigation.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/providers/meals_provider.dart';
import 'package:meal_app/providers/filters_provider.dart';

const kInitializeFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIdx = 0;

  void _selectPage(int idx) {
    setState(() {
      _selectedPageIdx = idx;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(this);

    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // example of using provider
    final totalMeals = ref.watch(mealsProvider);
    final selectedFilter = ref.watch(filterProvider);

    final filteredMeals =
        FilterMealController().filterMeals(selectedFilter, totalMeals);

    Widget activePage = CategoriesScreen(
      availableMeals: filteredMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIdx == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
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
