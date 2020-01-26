import 'dart:core';

class Student{
  String name;
  bool sundayComing;
  bool mondayComing;
  bool tuesdayComing;
  bool wednesdayComing;
  bool thursdayComing;

  Student(String name, bool sundayComing, bool mondayComing, bool tuesdayComing, bool wednesdayComing, bool thursdayComing) {
    this.name = name;
    this.sundayComing = sundayComing;
    this.mondayComing = mondayComing;
    this.tuesdayComing = tuesdayComing;
    this.wednesdayComing = wednesdayComing;
    this.thursdayComing = thursdayComing;
  }

  String printStudent() {
    return name;
  }
}