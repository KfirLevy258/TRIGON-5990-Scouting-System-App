import 'package:flutter/material.dart';
typedef void StringCallback(String val);

Widget selectionInputWidget(String label, String dropDownLabel, List<String> options, StringCallback callback) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 200,
        child: selectionInput1(dropDownLabel, ["3 Inch", "4 Inch", "5 Inch", "6 Inch", "7 Inch",  "8 Inch"], callback),
      ),
      Padding(padding: EdgeInsets.all(4.0),),
      Container(
        width: 150,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
//              selectionInputRowBuild(_wheelDiameter),
    ],
  );

}

Widget selectionInput1(String dropDownLabel, List<String> options, StringCallback callback) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      DropdownButton(
        hint: Text(
          dropDownLabel,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: dropDownLabel=='Nothing Selected' ? Colors.red : Colors.grey),
        ),
        onChanged: (newValue) {
          callback(newValue);
        },
        items: options.map((option) {
          return DropdownMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  option,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            value: option,
          );
        }).toList(),
      ),
    ],
  );
}