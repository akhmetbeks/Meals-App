import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {

  Widget buildListTile(String title, IconData icon, VoidCallback func) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: func,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 130,
          width: double.infinity,
          color: Theme.of(context).colorScheme.secondary,
         
          padding: EdgeInsets.only(left: 30, top: 70),
          child: Text(
            'Cooking Up!',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor),
          ),
          // alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 20,),
        buildListTile('Meals', Icons.restaurant, (){
          Navigator.of(context).pushReplacementNamed('/');
        }),
        buildListTile('Filters', Icons.settings, (){
          Navigator.of(context).pushReplacementNamed(FiltersPage.routeName);
        })
      ]),
    );
  }
}
