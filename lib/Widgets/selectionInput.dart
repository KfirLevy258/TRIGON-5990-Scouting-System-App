import 'package:flutter/material.dart';
typedef void StringCallback(String val);

Widget selectionInputWidget(String label, List<String> options, StringCallback callback) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      DropdownButton(
        hint: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: label=='Nothing Selected' ? Colors.red : Colors.grey),
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