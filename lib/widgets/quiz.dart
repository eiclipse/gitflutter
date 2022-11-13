import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class MainQuiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questions;
  final Function indexScoreHandler;

  const MainQuiz({
    required this.questionIndex,
    required this.questions,
    required this.indexScoreHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['question'] as String),
        /*

        _questions -> List<Map<String,Object>> 임. 즉 맵형 리스트
        _questions[_questionIndex] -> 위 맵형 리스트에서 특정 인덱스를 가져오므로 하나의 맵형을 가리킴
            -> 즉 하나의 question과 리스트를 가진 answers를 포함한 맵
        _questions[_questionIndex]['answers'] -> 한 세트의 질문 답변들에서 답변 리스트를 가리킴

        버튼을 구성하는 Answer 클래스 생성자로 넘겨주기 위해 총 3의 길이로 이뤄진 답변 리스트에서 각각의 답변을 꺼내와야 함.
        그래서 일단 _questions[_questionIndex]['answers'] 를 String형 리스트로 명시적 형변환


        그 후 리스트같은 iterable 객체를 기준으로 foreach 를 돌려주는 역할의 map 함수를 사용
        _questions[_questionIndex]['answers'] as List<String>).map((e) => ...)
        여기서 map 함수 안의 익명함수()의 매개변수 e는 위의 String형 리스트(각각의 답변이 담긴)를 돌며 각 인덱스에 해당하는
        값을 담는 역할

        java 라면 for문의 변수 e 역활과 같음
        String[] list = ["a", "b", "c"];
        for(String e : list){  ....  };

        map함수를 이용해 리스트의 답변의 수만큼 반복할때마다 매개변수 e에 담기 각 답변을 넘겨
        Answer 생성자를 호출해 버튼 위젯을 생성함.
        Answer 클래스 내부적으로 컨테이너 위젯을 반환하기 때문에
        (_questions[_questionIndex]['answers'] as List<String>).map((e) => Answer(e, _indexHandler))
        여기까지의 코드를 통해 Answer형 Iterable 객체를 반환받을 수 있게 됨.

        그러나 Column의 children 요소로는 Widget만 들어갈 수 있음.

        Iterable 객체를 펼쳐 List, Map 등에 삽입해주는 역할을 하는 스프레드 연산자(...)을 이용해
        children의 [] 리스트에 추가해주므로써 각각의 Answer 위젯이 들어감.
        --- 여기까지가 score 들어가기 전 버전

        _questions -> List<Map<String,Object>> 임. 즉 맵형 리스트
        _questions[_questionIndex] -> 위 맵형 리스트에서 특정 인덱스를 가져오므로 하나의 맵형을 가리킴
            -> 즉 하나의 question과 맵을 가진 answers를 포함한 맵
        _questions[_questionIndex]['answers'] -> text, score 키를 가진 맵을 담은 리스트
        */
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((e) {
          return Answer(
            e['text'] as String,
                () => indexScoreHandler(e['score']),
          );
        }),
      ],
    );
  }
}
