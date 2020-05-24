class Strings {
  static const String appName = 'Expenseye';
  static const String versionNumber = '1.2.4';

  static const String appBy = 'App by Antoine Ho, 2020';

  // * EXPENSE categories
  static const String food = 'Food';
  static const String transportation = 'Transportation';
  static const String shopping = 'Shopping';
  static const String entertainment = 'Entertainment';
  static const String activity = 'Activity';
  static const String medical = 'Medical';
  static const String home = 'Home';
  static const String travel = 'Travel';
  static const String people = 'People';
  static const String education = 'Education';
  static const String others = 'Others';
  static const String otherExpenses = 'Other Expenses';

  // * INCOME categories
  static const String salary = 'Salary';
  static const String gift = 'Gift';
  static const String business = 'Business';
  static const String insurance = 'Insurance';
  static const String realEstate = 'Real Estate';
  static const String investment = 'Investment';
  static const String refund = 'Refund';
  static const String otherIncomes = 'Other Incomes';

  // * ITEM DATABASE table and column names
  static const String dbFileName = 'itemsDb.db';
  static const String tableItems = 'items';
  static const String itemColumnId = 'expense_id'; // TODO: rename to item id
  static const String itemColumnName = 'name';
  static const String itemColumnValue = 'value';
  static const String itemColumnDate = 'date';
  static const String itemColumnCategory = 'category';
  static const String itemColumnType = 'type';

  // * CATEGORIES DATABASE table and column names
  static const String tableCategories = 'categories';
  static const String categoryColumnId = 'category_id';
  static const String categoryColumnName = 'name';
  static const String categoryColumnIconCodePoint = 'icon_code_point';
  static const String categoryColumnColor = 'color';
  static const String categoryColumnType = 'type';

  // * RECCURENT ITEMS DATABASE table and extra column names
  static const String tableRecurrentItems = 'recurrent_items';
  static const String recurrentItemColumnId = 'recurrent_item_id';
  static const String recurrentItemColumnName = 'name';
  static const String recurrentItemColumnValue = 'value';
  static const String recurrentItemColumnDay = 'day';
  static const String recurrentItemColumnCategory = 'category';
  static const String recurrentItemColumnIsAdded = 'is_added';
}
