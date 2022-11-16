import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitpractice01/apis/web/PapagoAPI.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

import '../../components/Guide.dart';
import '../../dao/MessagesDAO.dart';
import '../../dto/MessagesDTO.dart';
import '../../providers/MainActivityProvider.dart';

class TabViewFactory with ChangeNotifier{

  // PAPAGO Related
   final TextEditingController _fromMessageController = TextEditingController();

  // DB_Insert Related
   final TextEditingController _messageController = TextEditingController();
   final TextEditingController _writerController = TextEditingController();
   final FocusNode _writerFocusNode = FocusNode();

  // prevent spam filter
   int i = 1;

   getTextTabView(String str){
    return Text(str);
  }

   getUITabView(){
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

   getPapagoTabView(BuildContext context){
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

   get_DBInsert_TabView(BuildContext context){
    var data = Provider.of<MainAcitivityProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: _writerFocusNode,
            controller: _writerController,
            decoration: InputDecoration(labelText: 'Writer',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
            style: TextStyle(
                fontSize: 20
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _messageController,
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Message',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
            style: TextStyle(
                fontSize: 20
            ),
          ),
        ),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: Colors.blueAccent
              ),
            ),
            onPressed: (){
              String writer = _writerController.text;
              String message = _messageController.text;

              Dialogs.materialDialog(
                  msg: '이대로 글 작성을 완료하시겠습니까?',
                  title: "글 입력 확인",
                  color: Colors.white,
                  context: context,
                  actions: [
                    IconsOutlineButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: '취소',
                      iconData: Icons.cancel_outlined,
                      textStyle: TextStyle(color: Colors.grey),
                      iconColor: Colors.grey,
                    ),
                    IconsButton(
                      onPressed: () {
                        data.insert(writer,message);
                        Navigator.pop(context);

                        Dialogs.materialDialog(
                            msg: '입력이 완료되었습니다.',
                            title: "확인",
                            color: Colors.white,
                            context: context,
                            actions: [
                              IconsOutlineButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _writerController.text="";
                                  _messageController.text="";
                                  _writerFocusNode.requestFocus();
                                },
                                text: '확인',
                                iconData: Icons.cancel_outlined,
                                textStyle: TextStyle(color: Colors.grey),
                                iconColor: Colors.grey,
                              )
                            ]
                        );
                      },
                      text: '확인',
                      iconData: Icons.add_circle,
                      color: Colors.blueAccent,
                      textStyle: TextStyle(color: Colors.white),
                      iconColor: Colors.white,
                    ),
                  ]
              );
            },
            child: Text("기록하기",style: TextStyle(
                color: Colors.blueAccent
            ),)
        )
      ],
    );
  }

   get_DBList_TabView(BuildContext context){
    var data = Provider.of<MainAcitivityProvider>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 8.0, 8.0, 8.0),
      child: Column(
        children: [
          Container(
              width:double.infinity,
              height:60,
              child: const Align(
                child: Text(
                  "Message List",
                  style:TextStyle(
                    fontSize: 30,
                  ),
                ),
              )
          ),
          Expanded(
            child: FutureBuilder(
                future: data.messages,
                builder: (ctx, AsyncSnapshot<List<MessagesDTO>> snapshot){
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onLongPress: (){
                            if(data.deleteMode){
                              data.deleteMode = false;
                            }else{
                              data.deleteMode = true;
                            }
                          },
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                  height:60,
                                  child: ListTile(
                                    dense: true,
                                    minLeadingWidth: 0,
                                    horizontalTitleGap: 0,
                                    contentPadding: EdgeInsets.all(0),
                                    leading: data.deleteMode ?
                                    Checkbox(
                                        value: snapshot.data![index].isChecked,
                                        onChanged: (bool? value) {
                                          print("${snapshot.data![index].isChecked} : ${i++}");
                                          data.isCheckedRefresh(snapshot.data![index]);
                                        }) : Container(width:0),
                                    title:SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          snapshot.data![index].message,
                                          style: const TextStyle(
                                            fontSize: 24,
                                          ),
                                        )
                                    ),
                                    subtitle: Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(width:1,color:Colors.grey)
                                          )
                                      ),
                                      child: Text("${snapshot.data![index].writer} / ${snapshot.data![index].write_date}",
                                        style: const TextStyle(
                                            color: Colors.grey
                                        ),
                                      ),
                                    ),
                                  )
                              )
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const Center(child: CircularProgressIndicator());
                }
            ),
          ),
          Container(
            width:double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width:1,color:Colors.grey)
            ),
            height:data.deleteMode?60:0,
            child: Row(
              children: [
                data.deleteMode?Expanded(
                  child: TextButton.icon(
                      icon: Icon(Icons.close),
                      label: Text("취소"),
                      onPressed: (){
                        data.deleteMode=false;
                        data.setAllIsChecked(false);
                      }
                  ),
                ):Container(),
                data.deleteMode?Expanded(
                  child: TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      icon: Icon(Icons.delete_forever),
                      label: Text("삭제"),
                      onPressed: (){
                        data.messages.then((value){
                          List<int> del_list = [];
                          value.forEach((e) {
                            if(e.isChecked){
                              del_list.add(e.seq);
                            }
                          });
                          data.removeAll(del_list);
                          data.deleteMode=false;
                        });
                      }
                  ),
                ):Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}