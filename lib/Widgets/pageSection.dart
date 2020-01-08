import 'package:flutter/material.dart';


Widget pageSectionWidget(String header, List<Widget> selectionWidgets) {
  List<Widget> children = [];
  children.add(
    Padding(padding: EdgeInsets.all(15.0),),
  );
  children.add(
    Text(
      header,
      style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
    ),
  );
  selectionWidgets.forEach((widget) {
    children.add(
      Padding(padding: EdgeInsets.all(8.0),),
    );
    children.add(widget);
  });

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children
    ),
  );
}