import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class MealDetail extends StatefulWidget {
  static const routeName = '/meal-detail';
  final Function isFavorite;
  final Function toggleFavorite;

  MealDetail(this.isFavorite, this.toggleFavorite);

  @override
  State<MealDetail> createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {


  Widget buildTextContainer(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget buildListContainer(Widget child) {
    return Container(
      width: 300,
      height: 150,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((meal) => id == meal.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildTextContainer(context, 'ingredients'),
            buildListContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(meal.ingredients[index]),
                    ),
                  );
                },
                itemCount: meal.ingredients.length,
              ),
            ),
            buildTextContainer(context, 'steps'),
            buildListContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(
                          meal.steps[index],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
                itemCount: meal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // elevation: 0,
        child: widget.isFavorite(meal.id)? const Icon(
          Icons.favorite,
          color: Colors.black,
          size: 30,
        ):const Icon(
          Icons.favorite_border,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          widget.toggleFavorite(meal.id);
        },
      ),
    );
  }
}
