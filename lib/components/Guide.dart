import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Guide{

  static Container getBorderedWidget(Widget w){
    return Container(
      decoration: BoxDecoration(
        border:Border.all(
          width:1,
          color: Colors.black
        )
      ),
      child: w,
    );
  }

}