import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/meals_provider.dart';

// ref.read -> To get the data from our provider once
// ref.watch -> To setup a listener, succh that build method is executed again as our data changes
// watch is always more preffered than read. Watch always need a "provider" as a arguement and always return data.

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

// We are creating a StateNotifier (It works with StateNotifierProvider class). It manages state of type: Map<Filter, bool>
// ********** StateNotifierProvider class works with StateNotifier Class only. **********
// Means that this will store filters.
// StateNotifier<Map<Filter, bool>> tells what kind of data will this StateNotifier will handle.
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()                                                 // Calls parent constructor with initial state
      : super({                                                     // [Initially non-empty]
          Filter.glutenFree: false,                                 // These are the initial values
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  void setFilters(Map<Filter, bool> chosenFilters) {                // state contains data.
    state = chosenFilters;                                          // Replace the entire filter state.
  }

  void setFilter(Filter filter, bool isActive) {                    // Updating a single filter.
    // state[filter] = isActive;                                    // not allowed! => mutating state
    // Not allowed because Riverpod requires immutable state and Direct modification won’t trigger UI updates.
    state = {
      ...state,                                                     // Copy old state [ state contains data ] 
      filter: isActive,                                             // Update only 1 value
    };
  }
}

// Creating a Provider. (StateNotifierProvider) is a ProviderClass provided by the Riverpod functionality
// Why not Simple Provider -> Because Provider is not optimised for the data that can change.
// ********** StateNotifierProvider class works with StateNotifier Class only. **********
final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>> ((ref)  {
  return FiltersNotifier();
});


// Creating a provider.
// final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>> (
//   (ref) => FiltersNotifier(),
// );


// Creates a derived provider. It does not store state. It Computes data based on other provider.
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);                             // Get full meals list. [ From the provider ]
  final activeFilters = ref.watch(filtersProvider);                   // Get current filter values


  return meals.where((meal) {                                         // Filtering meals using where
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {    // If filter is ON and meal is NOT gluten-free then remove meal
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;                                                      // If all conditions pass → keep meal
  }).toList();
});