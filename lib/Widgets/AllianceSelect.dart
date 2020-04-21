import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void StringCallback(String res);

Widget allianceSelect(StringCallback callback){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      FlatButton(
        color: Colors.blue,
        onPressed: (){
          callback("Blue");
        },
        child: Text(
          "Blue alliance",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.white),

        ),
      ),
      FlatButton(
        color: Colors.red,
        onPressed: (){
          callback("Red");
        },
        child: Text(
          "Red alliance",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    ],
  );
}
