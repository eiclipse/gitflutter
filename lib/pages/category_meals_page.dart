import 'package:flutter/material.dart';

import '../dummy_data.dart';

import '../widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsPage extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> _categoryMeals;

  const CategoryMealsPage(this._categoryMeals);

  @override
  State<CategoryMealsPage> createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
  late String title;
  late List<Meal> categoryMeals;

  /* initState 는 위젯이 build 되기 전, context가 로드되기 전 실행되므로 ModalRoute 사용이 안됨
  반면 didChangeDependencies는 context가 로드된 후, 하지만 build 전 실행되므로 ModalRoute 접근 가능
  * */
  @override
  void didChangeDependencies() {
    //  이 페이지를 push 시킨 위젯으로부터 넘겨받은 데이터는 ModalRoute.of(context).settings.arguments 로 꺼내쓸 수 있음
    final args =
    ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String id = args['id'] as String;
    title = args['title'] as String;
    categoryMeals = widget._categoryMeals.where((meal) {
      // 더미데이터 리스트를 돌며 지금 눌린 카테고리에 해당하는 Meal 만 모아 List 로 꾸림
      return meal.categories.contains(id);
    }).toList();

    super.didChangeDependencies();
  }

  void _deleteItem(String itemId){
    setState(() {
      categoryMeals.removeWhere((item) => item.id == itemId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 또다른 페이지이므로 Scaffold
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            affordability: categoryMeals[index].affordability,
            complexity: categoryMeals[index].complexity,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
