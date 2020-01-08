import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
typedef void BooleanCallback(bool val);

Widget booleanInputWidget(String label, bool initValue, BooleanCallback callback) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 180,
        child: CupertinoSwitch(
          value: initValue,
          onChanged: (bool value) {
            callback(value);
          },
        ),
      ),
      Padding(padding: EdgeInsets.all(20.0),),
      Container(
        width: 120,
        child:  Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
      Padding(padding: EdgeInsets.only(right: 10),),
    ],
  );
}