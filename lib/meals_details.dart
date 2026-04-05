import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/meal.dart';
import 'package:meals_app/favorites_provider.dart';

// ****************** This Widget is for the single Meal that we have reached upon after selecting. *********************

// Stateless Widget just display the UI. 
// ConsumerWidget is the stateless widget provided by the Riverpod Functionality
// Consumer Widget displays UI and listen to data changes. 
// ConsumerWidget is used when we need ref, we use providers and UI depends on state.
// ref.read -> To get the data from our provider once
// ref.watch -> To setup a listener, succh that build method is executed again as our data changes
// watch is always more preffered than read. Watch always need a "provider" as a arguement and always return data.
class MealDetailsScreen extends ConsumerWidget {                // Consumer Widget to get ref.
  const MealDetailsScreen({super.key,required this.meal});

  final Meal meal;                                              // Selected meal.

  @override
  Widget build(BuildContext context, WidgetRef ref) {           // ****** for this "ref" only we have used consumerWidget
    final favoriteMeals = ref.watch(favoriteMealsProvider);     // Helps in getting a list of favourite meals
    // .watch() listens to changes and rebuilds UI when state changes.

    final isFavorite = favoriteMeals.contains(meal);            // Check whether the current meal is favourite or not.

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),                              // Har Meal ka alag AppBar.
          actions: [                                            // Button on the Top Right.
            IconButton(
              onPressed: () {
                final wasAdded = ref                            // toggleMealFavoriteStatus return type is boolean.
                    .read(favoriteMealsProvider.notifier)       // .read() does not rebuilds UI. Just read the provider
                    .toggleMealFavoriteStatus(meal);            // Toggles the favourite status. notifier gives access to class -> FavoriteMealsNotifier
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        wasAdded ? 'Meal added as a favorite.' : 'Meal removed.'),
                  ),
                );
              },
              icon: AnimatedSwitcher(                           // Animating from one widget to another.
                duration: const Duration(milliseconds: 300),    // Duration
                transitionBuilder: (child, animation) {
                  return RotationTransition(                    // Rotating effect
                    turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                    child: child,
                  );
                },
                child: Icon(                                    // What we will animate (Child)
                  isFavorite ? Icons.star : Icons.star_border,
                  key: ValueKey(isFavorite),                    // CRUCIAL STEP because AnimatedSwitcher detects changes using keys
                  // When isFavorite changes: key changes → widget replaced → animation triggered
                ),
              ),
            )
          ]
        ),
        body: SingleChildScrollView(                            // Makes screen scrollable
          child: Column(
            children: [
              Hero(                                             // ***** Animation between various screens *****
                tag: meal.id,                                   // "tag" is important.  
                child: Image.network(                           // Way to add image from the Internet.
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(             // Using Custom theme.
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              const SizedBox(height: 24),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final step in meal.steps)                    // writing all the steps in the meal.
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
            ],
          ),
        ));
  }
}