import 'package:flutter/material.dart';
import '/dummy_data.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFav;
  final Function isFav; 
  MealDetail(this.toggleFav, this.isFav);

  Widget buildSelectedText(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15)),
      child: child,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedMeal.title),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSelectedText(context, 'Ingredients'),
              buildContainer(ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        selectedMeal.ingredients[index],
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                ),
                itemCount: selectedMeal.ingredients.length,
              )),
              buildSelectedText(context, 'Steps'),
              buildContainer(ListView.builder(
                  itemCount: selectedMeal.steps.length,
                  itemBuilder: (context, index) => Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                                child: Text('# ${(index + 1)}'),
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            title: Text(selectedMeal.steps[index]),
                          ),
                          Divider()
                        ],
                      ))),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(isFav(mealId) ? Icons.favorite : Icons.favorite_border),
          onPressed: () => toggleFav(mealId),
        ));
  }
}
