class Expense {
  DateTime time;
  String title;
  String note;
  double price;

  Expense(this.title, this.price) {
    time = DateTime.now();
    note = null;
  }
}