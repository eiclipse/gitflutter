import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  const Chart(this.transactions);

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      /*
      generate(길이, 함수)
        주어진 길이의 리스트를 만들고 index에는 길이만큼 인덱스를 반환함
        subtract(기간) : 기간에 해당하는 시간을 빼줌(즉 과거로..)
        Duration(days: 숫자) : 인덱스는 0부터 시작하므로 현재로부터 0일만큼 떨어진 날짜를 뻬고
        인덱스가 올라가면 현재로부터 1일,2일.. 이전 날짜를 빼내겠다는 것.
       */
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      // 오늘로부터 지난 일주일의 요일과 요일별 총 지출금액 뽑아내기
      int totalDay = 0;
      for (var tx in transactions) {
        if (DateUtils.isSameDay(weekDay, tx.date)) {
          totalDay += tx.amount;
        }
      }
      return {
        'day': DateFormat.E('ko_KR').format(weekDay).substring(0, 1),
        'amount': totalDay,
      };
    }).reversed.toList();
  }

  // 지난 일주일 총 지출금
  double get totalSpending {
    return _groupedTransactions.fold(
        0.0, (sum, item) => sum + (item['amount'] as int));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactions.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              /* FlexFit.tight -> Flexible 안에 포함된 차일드 요소가 강제로 가질 수 있는 사이즈만큼 갖게끔 함
              만약 Flexible이 없었다면 일요일의 지출만 있다면 금액의 크기가 늘어남에 따라 일요일 영역만 큰 사이즈를 가지게 됐을 것.
              * */
              child: ChartBar(
                tx['day'] as String,
                tx['amount'] as int,
                tx['amount'] == 0.0 ? 0.0 : (tx['amount'] as int) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
