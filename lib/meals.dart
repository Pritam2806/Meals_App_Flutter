import 'package:flutter/material.dart';

import 'package:meals_app/meal.dart';
import 'package:meals_app/meals_details.dart';
import 'package:meals_app/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key,this.title,required this.meals});            // Constructor

  final String? title;                                                      // Nullable 
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {                        // Navigation when we select a Meal.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(                                // Displaying a single Meal on the screen
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(                                                // Default value of the content Widget
      child: Column(                                                        // Used When Title is NULL.
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(                                                             // When we don't have any meal to display
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {                             // When we have a meal to display.
      content = ListView.builder(
        itemCount: meals.length,                        // Very important
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],                           // ******** Important line, Kaunsi meal par jaana hai. *********
          onSelectMeal: (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }

    if (title == null) {
      return content;                // Uh oh ... nothing here!
    }                                // Try selecting a different category!

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}