import 'package:flutter/material.dart';

class Category {                 // Basic structure of the "category of meal" for the app.
  const Category({required this.id, required this.title, this.color = Colors.orange});

  final String id;
  final String title;
  final Color color;
}