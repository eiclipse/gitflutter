import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PapagoAPI{

  static translateRequest(String text) async{
    String clientId = "7L2brzhCWOgHU8OxtcBn";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "587QI4rs0T";//애플리케이션 클라이언트 시크릿값";

    String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
    text = Uri.encodeComponent(text);

    Response resp = await http.post(Uri.parse(apiURL),
        headers: {
          "Content-type": "application/x-www-form-urlencoded; charset=UTF-8",
          "X-Naver-Client-Id": clientId,
          "X-Naver-Client-Secret": clientSecret
        },
        body: "source=en&target=ko&text="+text,
        encoding: Encoding.getByName("utf8")
    );

    Map<String,dynamic> result = jsonDecode(resp.body);
    try {
      String tmsg = "${result['message']['result']['translatedText']}";
      return tmsg;
    }on NoSuchMethodError{
      return "일일 사용량이 초과되어 번역 서비스를 사용할 수 없습니다.";
    }
  }

}