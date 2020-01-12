import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget numericInputWidget(String label, String measurementUnits, TextEditingController controller, int minVal, int maxVal, bool isInt, bool saved) {
  return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(4.0),),
          Container(
            width: 200,
            child: TextFormField(
                controller: controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: measurementUnits,
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)
                  ),
                ),
                validator: (value) {
                  if (!saved) {
                    if (value.isEmpty)
                      return 'Please enter value';
                    if (!isNumeric(value))
                      return 'Please enter only digits';
                    dynamic numericValue = double.parse(value);;
                    List<String> split = numericValue.toString().split('.');
                    if (isInt && split[1]!='0')
                      return 'Value must be int';
                    if (numericValue < minVal || numericValue > maxVal)
                      return 'Value between ' + minVal.toString() + ' and ' + maxVal.toString();
                  } else {
                    print(label);
                    print(value);
                    if (value.isNotEmpty){
                      print(value);
                      if (!isNumeric(value))
                        return 'Please enter only digits';
                      dynamic numericValue = double.parse(value);;
                      List<String> split = numericValue.toString().split('.');
                      if (isInt && split[1]!='0')
                        return 'Value must be int';
                      if (numericValue < minVal || numericValue > maxVal)
                        return 'Value between ' + minVal.toString() + ' and ' + maxVal.toString();
                    }
                  }
                  return null;
                }
            ),
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
          Padding(padding: EdgeInsets.all(4.0),),
        ],
      )
  );
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}