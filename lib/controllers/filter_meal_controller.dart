import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/filters_provider.dart';

class FilterMealController {
  List<Meal> filterMeals(
     // where() method: create a list of item satisfied conditions
      Map<Filter, bool> selectedFilters, List<Meal> allMeals) {
    return allMeals.where((meal) {
      if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilters[Filter.vegan]! && meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
  }
}
