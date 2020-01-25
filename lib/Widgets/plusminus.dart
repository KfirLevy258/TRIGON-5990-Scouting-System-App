import 'package:flutter/material.dart';

typedef void IntCallBack(int val);

Widget plusMinus(int initValue, String label, IntCallBack callBack) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Expanded(
        flex: 5,
        child: Container(
          child: plusMinusWidget(initValue, callBack),
        ),
      ),
      Padding(padding: EdgeInsets.all(4.0),),
      Expanded(
        flex: 5,
        child: Container(
          width: 150,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ),
      ),
    ],
  );
}

Widget plusMinusWidget(int initValue, IntCallBack callBack){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 40,
        child: FlatButton(
          color: Colors.green,
          child: Text(
            '+',
          ),
          onPressed: () {
            callBack(initValue = initValue + 1);
          },
        ),
      ),
      Padding(padding: EdgeInsets.all(7),),
      Text(initValue.toString()),
      Padding(padding: EdgeInsets.all(7),),
      Container(
        width: 40,
        child: FlatButton(
          color: Colors.red,
          child: Text(
            '-',
          ),
          onPressed: () {
            if (initValue - 1<0){
              callBack(initValue);
            } else {
              callBack(initValue = initValue - 1);
            }
          },
        ),
      )
    ],
  );
}