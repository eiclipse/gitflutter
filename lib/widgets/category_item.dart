import 'package:flutter/material.dart';

import '../pages/category_meals_page.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem({
    Key? key,
    required this.id,
    required this.title,
    required this.color,
  }) : super(key: key);

  void _selectCategory(BuildContext ctx) {
    /* Navigator.of(context).push() 페이지 Stack에서 현재 페이지 위로 새로운 페이지를 쌓기 위한 함수
    새로운 페이지를 감싸는 애니메이션 효과를 주는 래퍼-> MaterialPageRoute
    즉석으로 새로운 페이지를 올리고 싶으면 MaterialPageRoute 를 사용
        Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) => CategoryMeals(id: id, title: title),
      ),
    );

    pushNamed -> main 에서 등록해둔 routes 를 사용할때 부르는 함수
    첫번째 인자 : 등록해둔 route 의 키값
    두번째 인자 : 등록된 페이지 위젯에 인자값을 넘겨줘야하는 경우
    */

    Navigator.of(ctx).pushNamed(
      CategoryMealsPage.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
