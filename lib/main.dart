import 'package:flutter/material.dart';

import './dummy_data.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/filters_screen.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten-free': false,
    'lactose-free': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _saveFilters(Map<String, bool> updatedFilters) {
    setState(() {
      _filters = updatedFilters;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten-free']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose-free']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian!) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFav(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFav(String mealId){
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MealsApp",
      theme: ThemeData(
          primaryColor: Colors.indigo,
          colorScheme: ColorScheme.fromSwatch(accentColor: Colors.indigo[100]),
          canvasColor: Colors.teal[50],
          fontFamily: 'Raleways',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Colors.black),
              bodyText2: TextStyle(color: Colors.black38),
              headline6: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: TabsScreen(_favoriteMeals),
      routes: {
        CategoryMeal.routeName: (ctx) => CategoryMeal(_availableMeals),
        MealDetail.routeName: (ctx) => MealDetail(_toggleFav, _isMealFav),
        FiltersPage.routeName: (ctx) => FiltersPage(_filters, _saveFilters)
      },
    );
  }
}
