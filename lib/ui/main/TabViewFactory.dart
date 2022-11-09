import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitpractice01/apis/web/PapagoAPI.dart';
import 'package:provider/provider.dart';

import '../../components/Guide.dart';
import '../../providers/MainActivityProvider.dart';

class TabViewFactory with ChangeNotifier{
  static final TextEditingController _fromMessageController = TextEditingController();

  static getTextTabView(String str){
    return Text(str);
  }

  static getUITabView(){
    return ListView(
      children: [
        Container(                    // Vertical ListView 의 첫번째 아이템 : CarouselSlider
            padding: EdgeInsets.all(10),
            child:CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
              ),
              items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.amber
                        ),
                        child: Text('text $i', style: const TextStyle(fontSize: 16.0),)
                    );
                  },
                );
              }).toList(),
            )
        ),
        Container(                      // Vertical ListView의 두 번째 아이템 : Horizontal ListView
          height:120,
          decoration: BoxDecoration(border: Border.all(width:1)),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Guide.getBorderedWidgetWithSize(Icon(Icons.favorite,),100,100),
              Guide.getBorderedWidgetWithSize(Icon(Icons.zoom_in_outlined,),100,100),
              Guide.getBorderedWidgetWithSize(Icon(Icons.yard,),100,100),
              Guide.getBorderedWidgetWithSize(Icon(Icons.wifi,),100,100),
              Guide.getBorderedWidgetWithSize(Icon(Icons.star,),100,100),

            ],
          ),
        ),
      ],
    );
  }

  static getPapagoTabView(BuildContext context){

    var data = Provider.of<MainAcitivityProvider>(context);

    return Column(
      children: [
        Expanded(         // From box
          flex:30,
          child: FractionallySizedBox(
            heightFactor: 0.95,
            widthFactor: 0.95,
            child: Column(
              children: [
                Expanded(
                    flex:2,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1,color:Colors.grey)
                          )
                      ),
                      child: Stack(
                        children: const [
                          Positioned(
                              left:3,
                              bottom:3,
                              child: Text("번역 할 메세지 입력",style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color:Colors.black,
                                fontSize: 16
                              ),)
                          )
                        ],
                      ),
                    )
                ),
                Expanded(
                    flex:8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Input english for translate to korean"
                        ),
                        controller: _fromMessageController,
                        style: TextStyle(fontSize: 16),
                        maxLines: 20,
                      ),
                    )
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex:10,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey)
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  if(_fromMessageController.text.trim()==""){
                    _fromMessageController.text="";
                    return;
                  }

                  print(_fromMessageController.text);

                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  Future<dynamic> result = PapagoAPI.translateRequest(_fromMessageController.text);
                  result.then((value) => data.papagoResult=value);
                  data.papagoBeforeText = _fromMessageController.text;
                  _fromMessageController.text="";
                }, child: Text("Translate")),
              ],
            ),
          ),
        ),
        Expanded(
          flex:30,
          child: FractionallySizedBox(
              heightFactor: 0.95,
              widthFactor: 0.95,
              child:Column(
                  children: [
                    Expanded(
                        flex:2,
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:BorderSide(
                                      width: 1,
                                      color:Colors.blueAccent
                                  )
                              )
                          ),
                          child: Stack(
                            children: const [
                              Positioned(
                                left:3,
                                bottom:3,
                                child: Text("번역 요청 한 문장",
                                  style:TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.blueAccent
                                  ),
                                )
                                ,
                              )
                            ],
                          ),
                        )
                    ),
                    Expanded(
                        flex:8,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data.papagoBeforeText,overflow: TextOverflow.visible),
                              )
                          ),
                        )
                    )
                  ]
              )
          ),
        ),
        Expanded(         // to Box
          flex: 30,
          child: FractionallySizedBox(
              heightFactor: 0.95,
              widthFactor: 0.95,
              child:Column(
                  children: [
                    Expanded(
                        flex:2,
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color:Colors.pink
                                  )
                              )
                          ),
                          child: Stack(
                            children: const [
                              Positioned(
                                  left:3,
                                  bottom:3,
                                  child: Text("번역 완료된 문장",
                                    style:TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.pink
                                    ),
                                  )
                              )
                            ],
                          ),
                        )
                    ),
                    Expanded(
                        flex:8,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data.papagoResult,overflow: TextOverflow.visible,textAlign: TextAlign.start,),
                              )
                          ),
                        )
                    )
                  ]
              )
          ),
        ),
      ],
    );
  }
}