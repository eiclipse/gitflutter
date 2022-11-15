import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        : ListView.builder(
            itemBuilder: (tx, index) {
              // 리스트빌더를 이용해 만들어낼 리스트 위젯
              return Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                elevation: 8,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(
                        child: Text(
                          '₩ ${NumberFormat('###,###,###').format(transactions[index].amount)}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat('yMEd', 'ko_KR')
                        .format(transactions[index].date),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    color: Theme.of(context).errorColor,
                    tooltip: 'delete transaction',
                    onPressed: () => _deleteTransaction(transactions[index].id),
                  ),
                ),
              );
            },
            itemCount: transactions.length, // 몇 개의 리스트를 뽑아낼지
          );
  }
}
