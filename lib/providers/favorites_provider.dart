import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

class FavMealsNotifier extends StateNotifier<List<Meal>> {
  FavMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    // this is code in tabs_screen.dart
    // final isExisting = _favoriteMeals.contains(meal);

    // if (isExisting) {
    //   setState(() {
    //     _favoriteMeals.remove(meal);
    //   });
    //   _showMessage('Remove from favorite');
    // } else {
    //   setState(() {
    //     _favoriteMeals.add(meal);
    //   });
    //   _showMessage('Add to favorite');
    // }

    // this is new code
    final isFavMeal = state.contains(meal);

    if (isFavMeal) {
      state = state.where((m) => m.id != meal.id).toList();
      return true;
    } else {
      state = [...state, meal];
      return false;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavMealsNotifier, List<Meal>>(
        (ref) => FavMealsNotifier());
