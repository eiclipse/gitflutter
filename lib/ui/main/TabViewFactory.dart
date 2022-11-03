import 'package:carousel_slider/carousel_slider.dart';
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
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.amber
                      ),
                      child: Text('text $i', style: TextStyle(fontSize: 16.0),)
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

}