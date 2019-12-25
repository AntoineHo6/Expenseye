import 'dart:ui';

class Expense {
  DateTime time;
  String name;
  double price;
  Image image;

  Expense(this.name, this.price) {
    time = DateTime.now();  // later put it as an arg
  }
}