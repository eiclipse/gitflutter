import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;

    final title = _titleController.text;
    final amount = int.parse(_amountController.text);
    // if nothing is typed
    if (title.isEmpty || amount <= 0 || _selectedDate == null) return;

    widget.addTransaction(
      // add data to list
      title,
      amount,
      _selectedDate
    );

    Navigator.of(context).pop(); // close modal
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((date) { // 사용자가 데이트피커를 연 후 취소/확인 버튼을 눌렀을 때 실행됨.
      setState(() {
        if(date != null) _selectedDate = date; // 날짜를 선택했다면
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            onSubmitted: (_) => _submitData(),
            /* onSubmitted 는 String 매개변수를 받는 함수를 넘겨줘야 함
               but submitData는 매개변수가 필요없는 함수라
               사용하지 않는 매개변수를 받는 익명함수를 만들어 내부적으로 submitData를 넘겨야하는데
               여기 _ 는 매개변수를 내부적으로 사용하지 않겠다는 의미를 가진 symbol
             */
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              label: Text('Amount'),
            ),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedDate == null ? 'Date has not chosen.' : DateFormat('yMEd', 'ko_KR').format(_selectedDate!),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextButton(
                onPressed: _showDatePicker,
                child: const Text('Choose Date!'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: const Text(
              'Add Transaction',
            ),
          ),
        ],
      ),
    );
  }
}
