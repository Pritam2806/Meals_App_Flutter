# Meals App (Flutter + Riverpod)

**Meals App** is built using **Flutter** and **Riverpod** that allows users to explore meals, apply dietary filters and manage their favorite dishes.

## Features
* Browse meals by different categories
* Using Images from the Internet
* Use of Sidebars and BottomNavigationBars
* Navigation from one screen to another
* Smooth grid layout with animations
* View meals under selected category
* Displays: Duration, Complexity, Affordability for each meal
* Add/remove meals from favorites
* Animated star icon toggle
* Favorites stored using Riverpod state
* Apply dietary filters:
  * Gluten-Free
  * Lactose-Free
  * Vegetarian
  * Vegan

## UI/UX

* Clean Material Design
* Smooth animations (Slide + Rotation)
* Hero transitions for images
* This app uses **Riverpod** for state management:
---

## How It Works

### Filtering Flow

```
User toggles filter
        ↓
filtersProvider updates
        ↓
filteredMealsProvider recalculates meals
        ↓
UI rebuilds automatically
```

### Favorites Flow

```
User taps star icon
        ↓
favoriteMealsProvider updates list
        ↓
UI updates with animation
```
---

## Key Concepts Used

* Flutter Widgets (Stateless & Stateful)
* Riverpod (StateNotifier, Provider)
* Navigation (Navigator, Routes)
* Animations:
  * AnimationController
  * AnimatedSwitcher
  * SlideTransition

---

## ⚡ Future Improvements

* 🔄 Persistent storage 
* 🌙 Light mode support

---

## Author

**Pritam Singh**
