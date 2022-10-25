import 'package:flutter/material.dart';

import 'package:meals_app/screens/category_meal_screen.dart';
import '../models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category catItem;
  CategoryItem(this.catItem);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMeal.routeName,
      arguments: {
        'id': catItem.id,
        'title': catItem.title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          catItem.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              catItem.color.withOpacity(0.5),
              catItem.color,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
