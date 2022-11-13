import 'package:flutter/material.dart';
import './widgets/quiz.dart';
import './widgets/result.dart';

// void main(){
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _title = 'Quiz App Pract.';
  int _questionIndex = 0;
  int _totalScore = 0;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'What\'s your favorite food?',
      'answers': [
        {'text': 'ramen', 'score': 1},
        {'text': 'pork barbecue', 'score': 5},
        {'text': 'cream cake', 'score': 10},
      ]
    },
    {
      'question': 'What\'s your favorite season?',
      'answers': [
        {'text': 'summer', 'score': 1},
        {'text': 'winter', 'score': 5},
        {'text': 'fall', 'score': 10},
      ]
    },
    {
      'question': 'What\'s your favorite coffee?',
      'answers': [
        {'text': 'cappuccino', 'score': 1},
        {'text': 'vanilla latte', 'score': 5},
        {'text': 'americano', 'score': 10},
      ]
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      if (_questionIndex < _questions.length) {
        _totalScore += score;
        _questionIndex++;
      } else {
        _questionIndex = 0;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Practice Quiz App'),
        ),
        body: _questionIndex < _questions.length
            ? MainQuiz(
            questionIndex: _questionIndex,
            questions: _questions,
            indexScoreHandler: _answerQuestion)
            : Result(_totalScore, _restartQuiz),
      ),
    );
  }
}
