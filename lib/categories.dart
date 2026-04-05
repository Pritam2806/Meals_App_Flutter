import 'package:flutter/material.dart';

import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/meal.dart';
import 'package:meals_app/category_grid_item.dart';
import 'package:meals_app/meals.dart';
import 'package:meals_app/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key,required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() {
    return _CategoriesScreenState();
  }
}

// ********************************** Setting an Explicit Animation ************************************
class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin provides a ticker (frame signal) for animations (Required for AnimationController)
  late AnimationController _animationController;     // Declares animation controller [late → initialized later in initState()]

  @override
  void initState() {                                 // Called when widget is created.
    super.initState();

    _animationController = AnimationController(
      vsync: this,                                   // Uses "this" widget as ticker provider (provides smooth animations)
      duration: const Duration(milliseconds: 300),   // Duration is 300 milliseconds
      lowerBound: 0,
      upperBound: 1,                                 // Animation value range (0 to 1)
    );

    _animationController.forward();                  // Start animation immediately
  }

  @override
  void dispose() {                                   // Cleans up the animation controller
    _animationController.dispose();                  // Prevents the memory leak and perfomance issues.
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals                          // Contains all meals
        .where((meal) => meal.categories.contains(category.id))          // If meal belong to selected category then keep it
        .toList();
    
    // Navigator.of(context).push(route);                // Mainly the syntax used for the navigation.
    Navigator.of(context).push(
      MaterialPageRoute(                                 // Here the route is created using the MaterialPageRoute
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,                          // Just Display list of the Dishes belonging to this category.
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(                                   // Rebuilds UI when animation updates. 
      animation: _animationController,                          // Efficient beacuase only rebuilds animated part
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(          // Defines the grid structure
          crossAxisCount: 2,                                                    
          childAspectRatio: 3 / 2,                                              // Width : Height ratio
          crossAxisSpacing: 20,                                                 // Spacing between the items.
          mainAxisSpacing: 20,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          for (final category in availableCategories)                           // Using for loop for grid items
            CategoryGridItem(                                                   
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);                             // When we click on a GridItem.
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(                             // Slide_animation
        position: Tween(                                                        // Defines movement
          begin: const Offset(0, 0.3),                                          // Start → slightly below (0, 0.3)
          end: const Offset(0, 0),                                              // End → original position (0, 0)
        ).animate(CurvedAnimation(                                              // Links animation to controller
            parent: _animationController,
            curve: Curves.easeInOut,                                            // Smooth animation
          ),
        ),
        child: child,                                                           // Animation applied on Gridview
      ),
    );
  }
}