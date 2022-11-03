import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Guide{

  static Container getBorderedWidget(Widget w){
    return Container(
      decoration: BoxDecoration(
        border:Border.all(
          width:1,
          color: Colors.red
        )
      ),
      child: w,
    );
  }

  static Container getBorderedWidgetWithSize(Widget w,double width, double height){
    return Container(
      width:width,
      height:height,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:Border.all(
              width:1,
              color: Colors.red
          )
      ),
      child: w,
    );
  }
  


  static ListView getDummyListView(){
    return ListView(
      children: [
        getBorderedWidget(ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),)),
        getBorderedWidget(ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),)),
        getBorderedWidget(ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),)),
        getBorderedWidget(ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),)),
        getBorderedWidget(ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),)),
        getBorderedWidget(ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),)),
        getBorderedWidget(ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),)),
        getBorderedWidget(ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),)),
        getBorderedWidget(ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),)),
        getBorderedWidget(ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),)),
      ],
    );
  }


}