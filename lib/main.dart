import 'package:flutter/material.dart';

import './dummy_data.dart';
import './pages/filters_page.dart';
import './pages/tabs_page.dart';
import './pages/favorite_page.dart';
import './pages/category_meals_page.dart';
import './pages/categories_page.dart';
import './pages/meal_detail_page.dart';

import './models/filter.dart';
import './models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Filter _filter = Filter();
  List<Meal> _categoryMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilter() {
    setState(() {
      _categoryMeals = DUMMY_MEALS.where((meal) {
        if (_filter.isGlutenFree && !meal.isGlutenFree) return false;
        if (_filter.isLactoseFree && !meal.isLactoseFree) return false;
        if (_filter.isVegan && !meal.isVegan) return false;
        if (_filter.isVegetarian && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String itemId){
    final index = _favoriteMeals.indexWhere((item) => item.id == itemId);
    if(index >= 0) {
      setState(() {
        _favoriteMeals.removeAt(index);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((item) => item.id == itemId));
      });
    }
  }

  bool _isFavorite(String itemId){
    return _favoriteMeals.any((item) => item.id == itemId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'YummyMeals',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.pinkAccent,
            secondary: Colors.amber,
          ),
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                  letterSpacing: 0.5,
                ),
                bodyMedium: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                titleMedium: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        //home: const CategoriesScreen(),
        //initialRoute: '/', 기본적으로 이 상태가 깔려있음.
        routes: {
          /* 앱의 규모가 커졌을때 여러개의 페이지 관리를 용이하게 하기 위해서
      routes 에 페이지를 String 키를 이용해 등록해둘 수 있음
      그럼 각 페이지가 필요한 위젯에서 Navigator pushNamed 를 이용해
      등록된 라우터를 불러주면 됨.
      */
          '/': (_) => TabsPage(_favoriteMeals),
          // web처럼 / 는 첫 앱 화면 default 로 잡혀있음
          CategoryMealsPage.routeName: (_) => CategoryMealsPage(_categoryMeals),
          MealDetail.routeName: (_) => MealDetail(_isFavorite, _toggleFavorite),
          FiltersPage.routeName: (_) => FiltersPage(_filter, _setFilter),
        },
        // 어떤 페이지에도 도달하지 못했을 때 default 값. 에러페이지용으로도 많이 쓰임.
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (_) => CategoriesPage());
        });
  }
}
