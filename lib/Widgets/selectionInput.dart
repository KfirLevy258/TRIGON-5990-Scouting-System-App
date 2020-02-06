import 'package:flutter/material.dart';
typedef void StringCallback(String val);

Widget selectionInputWidget(String label, String dropDownLabel, List<String> options, StringCallback callback) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Expanded(
        flex: 5,
        child: Container(
          child: selectionInput1(dropDownLabel, options, callback),
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

Widget selectionInput1(String dropDownLabel, List<String> options, StringCallback callback) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      DropdownButton(
        hint: Text(
          dropDownLabel,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: dropDownLabel=='לא נבחר' ? Colors.red : Colors.grey),
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