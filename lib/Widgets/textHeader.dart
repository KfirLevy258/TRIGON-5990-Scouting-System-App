import 'package:flutter/cupertino.dart';

Widget textHeader(String text) {
  return Center(
    child: Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10.0),),
        Text(
          text, style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.all(8.0),),
      ],
    ),
  );
}