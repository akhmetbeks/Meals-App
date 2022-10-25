import 'package:flutter/material.dart';

import '/models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMeal extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  CategoryMeal(this.availableMeals);
  @override
  State<CategoryMeal> createState() => _CategoryMealState();
}

class _CategoryMealState extends State<CategoryMeal> {
  bool _leadedInitData = false;
  String? categoryTitle;
  List<Meal>? categoryMeals;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_leadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final String categoryId = routeArgs['id'] as String;
      categoryTitle = routeArgs['title'] as String;
      categoryMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _leadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String id) {
    setState(() {
      categoryMeals!.removeWhere((meal) => meal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: categoryMeals![index].id,
            title: categoryMeals![index].title,
            imageUrl: categoryMeals![index].imageUrl,
            duration: categoryMeals![index].duration,
            complexity: categoryMeals![index].complexity,
            affordability: categoryMeals![index].affordability,
            
          );
        },
        itemCount: categoryMeals!.length,
      ),
    );
  }
}
