import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/meal.dart';

// ref.read -> To get the data from our provider once
// ref.watch -> To setup a listener, succh that build method is executed again as our data changes
// watch is always more preffered than read. Watch always need a "provider" as a arguement and always return data.


// We are creating a StateNotifier (It works with StateNotifierProvider class). It manages state of type: List<Meal>
// ********** StateNotifierProvider class works with StateNotifier Class only. **********
// Means that this will store favorite meals list.
// StateNotifier<List<Meal>> tells what kind of data will this StateNotifier will handle.
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);                  // Calls parent constructor with initial state [Initially empty list]

  // Function to add or remove a meal from favorites. It returns true → added to favorite. It returns false → removed from favorites
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);        // Checks if meal exist in current state. [state contains data]

    if (mealIsFavorite) {                               // If meal is already favourite then remove it.
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } 
    else {                                              // If not favourite, then add it.
      state = [...state, meal];
      return true;
    }
  }
}

// Creating a Provider. (StateNotifierProvider) is a ProviderClass provided by the Riverpod functionality
// Why not Simple Provider -> Because Provider is not optimised for the data that can change.
// ********** StateNotifierProvider class works with StateNotifier Class only. **********
final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});