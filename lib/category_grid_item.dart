import 'package:flutter/material.dart';
import 'package:meals_app/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key,required this.category,required this.onSelectCategory});      // Constructor

  final Category category;
  final void Function() onSelectCategory;                 // ****** Function passed as Parameter ******
  // A function passed from parent. Called when item is tapped.

  @override
  Widget build(BuildContext context) {
    return InkWell(                                       // Adds touch and ripple effect. [ Can also use the gestureDetector s]
      onTap: onSelectCategory,                            // runs function when tapped. [ See line number 9 ]
      splashColor: Theme.of(context).primaryColor,        // Ripple color when we tap the item
      borderRadius: BorderRadius.circular(16),            // Circular effect at corners
      child: Container(
        padding: const EdgeInsets.all(16),                // Padding in all directions inside the box
        decoration: BoxDecoration(                        // Styling of the container
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(                     // Applying the Gradient effect
              colors: [
                category.color.withAlpha(140),
                category.color.withAlpha(230),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(        // Applying the theme of the app and color too.
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}