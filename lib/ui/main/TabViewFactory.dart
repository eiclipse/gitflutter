import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/Guide.dart';

class TabViewFactory{

  static getTextTabView(String str){
    return Container(
      child: Text(str),
    );
  }

  static getTotalTabView(){
    return ListView(
      children: [
        Container(                      // Vertical ListView의 첫 번째 아이템
          height:100,
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

}