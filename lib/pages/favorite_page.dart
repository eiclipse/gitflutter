import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorites';
  List<Meal> _favoriteMeals;

  FavoritePage(this._favoriteMeals);

  @override
  Widget build(BuildContext context) {
    return _favoriteMeals.isEmpty
        ? const Center(
            child: Text(
              'There is no favorite meal!',
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                id: _favoriteMeals[index].id,
                title: _favoriteMeals[index].title,
                imageUrl: _favoriteMeals[index].imageUrl,
                duration: _favoriteMeals[index].duration,
                affordability: _favoriteMeals[index].affordability,
                complexity: _favoriteMeals[index].complexity,
              );
            },
            itemCount: _favoriteMeals.length,
          );
  }
}
