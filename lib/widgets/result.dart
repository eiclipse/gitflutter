import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int _resultScore;
  final VoidCallback restartHandler;

  const Result(this._resultScore, this.restartHandler);

  String phrase() {
    String resultPhrase;
    if (_resultScore <= 3) {
      resultPhrase = 'You have bad taste!';
    } else if (_resultScore <= 15) {
      resultPhrase = 'You have good taste!';
    } else {
      resultPhrase = 'You have fantastic taste!';
    }
    return resultPhrase;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Total Score : $_resultScore',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
          Text(
            phrase(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:30),
            child: TextButton(
              onPressed: restartHandler,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.orange),
              ),
              child: const Text(
                'Restart Quiz!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
