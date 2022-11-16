import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      locale: const Locale(
        'ko',
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.orange,
          secondary: Colors.amber[900],
        ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              titleSmall: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
              labelMedium: const TextStyle(
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              labelSmall: const TextStyle(
                fontFamily: 'SUIT',
                color: Colors.black87,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: MyAppPage(),
    );
  }
}

class MyAppPage extends StatefulWidget {
  @override
  State<MyAppPage> createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  final List<Transaction> _transactions = [
    // 샘플 데이터
    // Transaction(
    //   id: '1',
    //   title: 'Hotdog',
    //   amount: 3000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'Nice Hat',
    //   amount: 10000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '3',
    //   title: 'Nice Wfdd',
    //   amount: 8000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '4',
    //   title: 'Nice SVC',
    //   amount: 5000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '5',
    //   title: 'Nice TYG',
    //   amount: 60000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '5',
    //   title: 'Nice TYG',
    //   amount: 60000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '5',
    //   title: 'Nice TYG',
    //   amount: 60000,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;

  // new trasaction add function
  void _addTransaction(String title, int amount, DateTime date) {
    setState(() {
      _transactions.add(
        Transaction(
            id: '${UniqueKey().hashCode}',
            title: title,
            amount: amount,
            date: date),
      );
    });
  }

  // delete transaction function
  void _deleteTransaction(String id) {
    setState(() {
      // 리스트를 돌며 조건에 해당하는 요소 모두 제거
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  // show new transaction modal
  void _showNewTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Personal Expenses';
    // 앱이 리빌드될때마다 기기가 landscape 상태인지 여부를 boolean 값으로 저장
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    // portrait 모드로 돌아왔을때 차트스위치 꺼주기
    //if (!isLandscape) _showChart = false;

    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            // ios에서는 쿠퍼티노 네비바 적용
            backgroundColor: Theme.of(context).colorScheme.primary,
            middle: const Text(
              title,
            ),
            trailing: GestureDetector(
              // custom button
              onTap: _showNewTransaction,
              child: const Icon(CupertinoIcons.add),
            ),
          )
        : AppBar(
            title: const Text(title),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                iconSize: 45.0,
                onPressed: _showNewTransaction,
              ),
            ],
          );

    final txList = SizedBox(
      // 차트보기 스위치 꺼져있거나 portrait 모드일때 지출내역 70% 높이
      height: (MediaQuery.of(context).size.height -
          appBar.preferredSize.height -
          MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        _transactions,
        _deleteTransaction,
      ),
    );

    final appBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape) // landscape 모드에서만 스위치 보이기
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          if (!isLandscape) // landscape 모드 아닐때는 30% 높이로 차트 보이기
            SizedBox(
              /*MediaQuery.of(context).size .width/.height 기기의 크기 정보
           height 에 고정값을 주면 landscape 모드에서 고정값만큼 높이를 차지하면서
           위의 차트 부분이 위로 스크롤 됐을때 다시 스크롤을 내리는게 쉽지 않음
           기기의 높이의 상대적 height 로 설정해두면 landscape 모드에서도
           해당 퍼센트만 높이를 차지하기 때문에 chart를 스크롤하는게 어렵진 않음.
           또한 데이터가 없을 때도 화면이 스크롤되지 않음.
           appBar와 기본 top padding 을 뺀 100%를 기준으로 잡아야함
         */
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_transactions),
            ),
          if (!isLandscape) txList,
          if (isLandscape) _showChart
              ? SizedBox(
                  // landscape 모드이면서 차트보기 스위치 켜져있을땐 높이 70%로 차트보이기
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child: Chart(_transactions),
                )
              : txList
          // transaction area
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: appBody,
          )
        : Scaffold(
            appBar: appBar,
            body: appBody,
            floatingActionButton: Platform.isIOS
                ? Container() // ios에서는 플로팅 버튼 없는 것이 일반적인 UI
                : FloatingActionButton(
                    onPressed: _showNewTransaction,
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
