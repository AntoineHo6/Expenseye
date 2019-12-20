import 'dart:ui';

class Expense {
  DateTime time;
  String title;
  String note;
  double price;
  Image image;

  Expense(this.title, this.price) {
    time = DateTime.now();
    note = 'Add a note!';
  }
}