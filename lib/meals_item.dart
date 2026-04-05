import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:meals_app/meal_item_trait.dart';
import 'package:meals_app/meal.dart';

class MealItem extends StatelessWidget {                                      // No more further UI Updates [ Stateless ]
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;                                // When we select a meal

  // Below we have two getter functions for getting the output in the desired form.
  String get complexityText {                                             // Capitalizing the first letter in complexity
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

  String get affordabilityText {                                          // Capitalizing the first letter in affordability
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  @override 
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),                                    // Adds spacing around the card.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),                           // Rounded corners of the cards.
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,                                                       // Shadow impact on card
      child: InkWell(                                                     // Tapping effect on tap
        onTap: () {
          onSelectMeal(meal);                                             // Go the particular meal on tap
        },
        child: Stack(                                                     // One on the other (Like - text on the image)
          children: [
            Hero(                                                         // ***** Animation between various screens *****
              tag: meal.id,
              child: FadeInImage(                                         // Displays image with fade-in effect
                placeholder: MemoryImage(kTransparentImage),              // Transparent placeholder while loading
                image: NetworkImage(meal.imageUrl),                       // Loads image form the internet
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(                                               // Places the container at the bottom of the container
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(                                       // Semi-transparent black background
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ...     [ Adds ... if too long ]
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,            // Available space ke centre mein 
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}