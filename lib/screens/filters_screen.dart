import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FiltersPage extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersPage(this.currentFilters, this.saveFilters);

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegeterian = false;
  var _vegan = false;

  @override
  void initState() {
    
    _glutenFree = widget.currentFilters['gluten-free']!;
    _lactoseFree = widget.currentFilters['lactose-free']!;
    _vegeterian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String subtitle,
    bool value,
    Function updatedValue,
  ) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: (newValue) {
          updatedValue(newValue);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    'gluten-free': _glutenFree,
                    'lactose-free': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegeterian,
                  };
                  widget.saveFilters(selectedFilters);
                  Navigator.of(context).pushReplacementNamed('/');
                },
                icon: Icon(Icons.savings_rounded))
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              child: Center(
                child: Text(
                  'Adjust your meal selection.',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                    'Gluten-Free',
                    'Only include gluten-free meals.',
                    _glutenFree,
                    (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Lactose-Free',
                    'Only include lactose-free meals.',
                    _lactoseFree,
                    (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegan',
                    'Only include vegan meals.',
                    _vegan,
                    (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegetarian',
                    'Only include vegetarian meals.',
                    _vegeterian,
                    (newValue) {
                      setState(() {
                        _vegeterian = newValue;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
