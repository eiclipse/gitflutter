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
  final List<Transaction> _transactions = [];

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 45.0,
            onPressed: _showNewTransaction,
          ),
        ],
      ),
      body: Column(children: [
        Chart(_transactions),
        // chart area
        Expanded(
          child: TransactionList(
            _transactions,
            _deleteTransaction,
          ),
        ),
        // transaction area
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewTransaction,
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
