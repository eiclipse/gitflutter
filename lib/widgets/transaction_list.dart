import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  const TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'Empty Transaction!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/empty_jar.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: transactions.map((tx) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(500),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                '₩ ${NumberFormat('###,###,###').format(tx.amount)}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        tx.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        DateFormat('yMEd', 'ko_KR').format(tx.date),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                        ),
                        color: Theme.of(context).errorColor,
                        tooltip: 'delete transaction',
                        onPressed: () => _deleteTransaction(tx.id),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
