import 'package:flutter/material.dart';

Widget numericRatioInputWidget(String label, String measurementUnitsCounter, String measurementUnitsDenominator,
    TextEditingController countController, TextEditingController denominatorController, int minVal, int maxVal, bool isInt, bool saved) {
  return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(4.0),),
          Expanded(
            flex: 5,
            child: Container(
              child: TextFormField(
                  controller: countController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: measurementUnitsCounter,
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
                      if (value!=''){
                        if (!isNumeric(value))
                          return 'Please enter only digits';
                        dynamic numericValue = double.parse(value);
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
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                ' / ',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: TextFormField(
                  controller: denominatorController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: measurementUnitsDenominator,
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
                      if (value!=''){
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
          ),
          Padding(padding: EdgeInsets.all(4.0),),
          Expanded(
            flex: 10,
            child: Container(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
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