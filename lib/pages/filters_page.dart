import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import '../models/filter.dart';

class FiltersPage extends StatefulWidget {
  static const routeName = '/filters';

  Filter _filter;
  final Function _setFilter;

  FiltersPage(this._filter, this._setFilter);

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {

  Widget _buildListTile(
      String title, bool currentVal, String subtitle, Function updateVal) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      value: currentVal,
      subtitle: Text(
        subtitle,
      ),
      activeColor: Theme.of(context).colorScheme.primary,
      onChanged: (val) => updateVal(val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildListTile(
                    'Gluten-free',
                    widget._filter.isGlutenFree,
                    'Only include gluten-free meals.',
                      (val){
                        setState(() {
                          widget._filter.isGlutenFree = val;
                          widget._setFilter();
                          //_isGlutenFree = val;
                        });
                      },
                  ),
                  _buildListTile(
                    'Lactose-free',
                    widget._filter.isLactoseFree,
                    'Only include lactose-free meals.',
                        (val){
                      setState(() {
                        widget._filter.isLactoseFree = val;
                        widget._setFilter();
                      });
                    },
                  ),
                  _buildListTile(
                    'Vegan',
                    widget._filter.isVegan,
                    'Only include vegan meals.',
                        (val){
                      setState(() {
                        widget._filter.isVegan = val;
                        widget._setFilter();
                      });
                    },
                  ),
                  _buildListTile(
                    'Vegetarian',
                    widget._filter.isVegetarian,
                    'Only include vegetarian meals.',
                        (val){
                      setState(() {
                        widget._filter.isVegetarian = val;
                        widget._setFilter();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
