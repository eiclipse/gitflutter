import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void submitData() {
    // if nothing is typed
    if (titleController.text.isEmpty || amountController.text.isEmpty) return;

    widget.addTransaction(
      // add data to list
      titleController.text,
      int.parse(amountController.text),
    );

    Navigator.of(context).pop(); // close modal
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            onSubmitted: (_) => submitData(),
            /* onSubmitted 는 String 매개변수를 받는 함수를 넘겨줘야 함
               but submitData는 매개변수가 필요없는 함수라
               사용하지 않는 매개변수를 받는 익명함수를 만들어 내부적으로 submitData를 넘겨야하는데
               여기 _ 는 매개변수를 내부적으로 사용하지 않겠다는 의미를 가진 symbol
             */
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(
              label: Text('Amount'),
            ),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
          ),
          TextButton(
            onPressed: submitData,
            child: const Text(
              'Add Transaction',
            ),
          ),
        ],
      ),
    );
  }
}
