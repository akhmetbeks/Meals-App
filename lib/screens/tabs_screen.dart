import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import '/screens/favories_screen.dart';
import '/screens/categories_screen.dart';


class TabsScreen extends StatefulWidget {
  List<Meal> _favoriteMeals;
  TabsScreen(this._favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>>? _pages;
  

  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
    {
      'page': CategoriesPage(),
      'title': 'Categories',
    },
    {
      'page': FavoriesPage(widget._favoriteMeals),
      'title': 'Your Favorites',
    }];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(_pages![_selectedPageIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _pages![_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedIconTheme: IconThemeData(color: Colors.white54),
          selectedIconTheme: IconThemeData(color: Colors.tealAccent[100]),
          unselectedItemColor: Colors.white54,
          selectedItemColor: Colors.tealAccent[100],
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorites'),
          ]),
    );
  }
}
