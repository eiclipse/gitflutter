import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String _text;
  final VoidCallback _indexScoreHandler;

  const Answer(this._text, this._indexScoreHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: _indexScoreHandler,
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        ),
        child: Text(_text),
      ),
    );
  }
}
