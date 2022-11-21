import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './list_item.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  const TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: [
                SizedBox(
                  height: constraint.maxHeight * 0.1,
                  child: Text(
                    'Empty Transaction!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.02,
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/empty_jar.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // SizedBox(
                //   height: constraint.maxHeight * 0.14,
                // ),
              ],
            );
          })
        : ListView(
            children: transactions
                .map((tx) => ListItem(
                      key:  ValueKey(tx.id),
                      transaction: tx,
                      deleteTransaction: _deleteTransaction,
                    ))
                .toList(),
          );
  }
}
    /*
    .builder(
     itemBuilder: (tx, index) {
        리스트빌더를 이용해 만들어낼 리스트 위젯
       return ListItem(transaction: transactions[index], deleteTransaction: _deleteTransaction);
     },
     itemCount: transactions.length, // 몇 개의 리스트를 뽑아낼지
    );
     */

