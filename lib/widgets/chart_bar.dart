import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final int amount;
  final double spendingPercent;

  const ChartBar(
    this.day,
    this.amount,
    this.spendingPercent,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(
              '₩ ${NumberFormat('###,###,###').format(amount)}',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            //alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(220, 223, 223, 223),
                ),
              ),
              FractionallySizedBox(
                // 지출량에 따른 높이 조절?
                heightFactor: spendingPercent,
                child: SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          day,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
