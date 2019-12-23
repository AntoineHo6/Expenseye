import 'dart:ui';

class Expense {
  DateTime time;
  String title;
  double price;
  Image image;

  Expense(this.title, this.price) {
    time = DateTime.now();  // later put it as an arg
  }
}