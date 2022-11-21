import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';


class ListItem extends StatefulWidget {
  const ListItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);
  // : super(key: key); 부모 생성자 초기화

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late Color _bgColor;

  @override
  void initState() {
    const colors = [
      Colors.red,
      Colors.blue,
      Colors.black,
      Colors.orangeAccent,
    ];
    _bgColor = colors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      elevation: 8,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
              child: Text(
                '₩ ${NumberFormat('###,###,###').format(widget.transaction.amount)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat('yMEd', 'ko_KR')
              .format(widget.transaction.date),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
          onPressed: () =>
              widget.deleteTransaction(widget.transaction.id),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).errorColor,
          ),
          icon: const Icon(Icons.delete),
          label: const Text('delete'),
        )
            : IconButton(
          icon: const Icon(
            Icons.delete,
          ),
          color: Theme.of(context).errorColor,
          tooltip: 'delete transaction',
          onPressed: () =>
              widget.deleteTransaction(widget.transaction.id),
        ),
      ),
    );
  }
}