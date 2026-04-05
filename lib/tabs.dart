import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/categories.dart';
import 'package:meals_app/filters.dart';
import 'package:meals_app/meals.dart';
import 'package:meals_app/main_drawer.dart';
import 'package:meals_app/favorites_provider.dart';
import 'package:meals_app/filters_providers.dart';

// Below is a mapping. [ Key = Enum, value = boolean ]
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

// A Stateful widget that uses Riverpod Functionaliy (ConsumerStatefulWidget)
// (ConsumerStatefulWidget) is a Stateful Widget provided by the Riverpod Functionality
// Consumer Widget displays UI and listen to data changes. 
// ConsumerWidget is used when we need ref, we use providers and UI depends on state. [ We need "ref" here ]
// ref.read -> To get the data from our provider once
// ref.watch -> To setup a listener, succh that build method is executed again as our data changes
// watch is always more preffered than read. Watch always need a "provider" as a arguement and always return data.
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;                      // Keeps track of current tab [0 → Categories, 1 → Favorites]

  void _selectPage(int index) {                    // Tab switching function [ for the BottomNavigationBar ]
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {       // Drawer Navigation function. [Handles navigation from drawer]
    Navigator.of(context).pop();                   // Closes the drawer after selecting an option.                  
    if (identifier == 'filters') {                 // When user on Filter Screen
      await Navigator.of(context).push<Map<Filter, bool>>(       // Opens Filters screen and waits for result 
        MaterialPageRoute(                                       // Expected return type: Map<Filter, bool>
          builder: (ctx) => const FiltersScreen(),               // Navigate to filter screen.
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);        // Gets meals after applying filters. Automatically rebuilds when data changes

    Widget activePage = CategoriesScreen(                           // Default Page of the App.
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);       // Get Favourite meals from provider. [ return type is List<Meals>]
      activePage = MealsScreen(     
        meals: favoriteMeals,                                       // Only show the favourite meals.
      );
      activePageTitle = 'Your Favorites';                           // Title updated.
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(                                           // drawer in the app
        onSelectScreen: _setScreen,
      ),
      body: activePage,                                             // Categories OR Favorites
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,                                         // Calls function when tab clicked.
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}