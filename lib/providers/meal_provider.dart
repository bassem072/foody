import 'package:flutter/material.dart';
import 'package:foody/dummy_data.dart';
import 'package:foody/models/category.dart';
import 'package:foody/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeal = DUMMY_MEALS;
  List<Category> availableCategory = DUMMY_CATEGORIES;
  List<Meal> favoriteMeals = [];
  List<String> prefsMealId = [];

  void setFilter() async {
    availableMeal = DUMMY_MEALS.where((meal) {
      if (!meal.isGlutenFree && filters["gluten"]!) {
        return false;
      }

      if (!meal.isLactoseFree && filters["lactose"]!) {
        return false;
      }

      if (!meal.isVegan && filters["vegan"]!) {
        return false;
      }

      if (!meal.isVegetarian && filters["vegetarian"]!) {
        return false;
      }
      return true;
    }).toList();

    availableCategory = DUMMY_CATEGORIES.where((category) {
      bool contain = false;
      availableMeal.forEach((meal) {
        if (meal.categories.contains(category.id)) {
          contain = true;
        }
      });
      return contain;
    }).toList();
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('gluten', filters['gluten'] ?? false);
    await prefs.setBool('lactose', filters['lactose'] ?? false);
    await prefs.setBool('vegan', filters['vegan'] ?? false);
    await prefs.setBool('vegetarian', filters['vegetarian'] ?? false);
  }

  setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;

    setFilter();

    prefsMealId = prefs.getStringList('prefsId') ?? [];

    for (String mealId in prefsMealId) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);

      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }

    List<Meal> fm = [];

    favoriteMeals.forEach((favMeal) {
      if (availableMeal.any((avaMeal) => favMeal.id == avaMeal.id))
        fm.add(favMeal);
    });

    favoriteMeals = fm;

    notifyListeners();
  }

  void toggleFavorite(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }
    notifyListeners();
    prefs.setStringList('prefsId', prefsMealId);
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }
}
