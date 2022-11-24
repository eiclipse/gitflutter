import 'package:flutter/material.dart';

import '../pages/meal_detail_page.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Affordability affordability;
  final Complexity complexity;

  const MealItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.affordability,
    required this.complexity,
  });

  String getComplexity() {
    String complexTxt = 'unknown';
    if (complexity == Complexity.Simple) complexTxt = 'Simple';
    if (complexity == Complexity.Challenging) complexTxt = 'Challenging';
    if (complexity == Complexity.Hard) complexTxt = 'Hard';
    return complexTxt;
  }

  String getAffordability() {
    String affordTxt = 'unknown';
    if (affordability == Affordability.Affordable) affordTxt = 'Affordable';
    if (affordability == Affordability.Pricey) affordTxt = 'Pricey';
    if (affordability == Affordability.Luxurious) affordTxt = 'Luxurious';
    return affordTxt;
  }

  void _selectMeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(
      MealDetail.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // 클릭해서 디테일 페이지로 넘어갈 수 있도록
      onTap: () => _selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          // 살짝 둥근 보더로 변경
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  // stack 안에서 포지션 조절
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 220, // 컨테이너에게 width 를 안주면 텍스트 크기만큼 너비 차지함
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
                    color: Colors.black54,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      //softWrap: true,
                      //overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('$duration min'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        getComplexity(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        getAffordability(),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
