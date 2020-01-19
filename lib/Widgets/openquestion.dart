import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget openQuestions(String measurementUnits, TextEditingController controller, bool isString, double width){
  return Container(
    width: width,
    child: TextFormField(
        maxLines: null,
        controller: controller,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.newline,
        keyboardType: isString ? TextInputType.multiline : TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          hintText: measurementUnits,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)
          ),
        ),
        validator: (value) {
          if (value.isEmpty){
            return 'Please enter value';
          }
          if (!isString && !isNumeric(value)){
            return 'Please enter Int';
          }
          return null;
        }
    ),
  );
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}