class Strings {
  static const String appName = 'Expenseye';
  static const String versionNumber = '1.2.2';

  // * BUTTON messages
  static const String addCaps = 'ADD';
  static const String submitCaps = 'SUBMIT';
  static const String cancelCaps = 'CANCEL';
  static const String saveCaps = 'SAVE';
  static const String confirmCaps = 'CONFIRM';
  static const String chooseMonthCaps = 'CHOOSE MONTH';
  static const String signInWithGoogle = 'Sign in with Google';
  static const String signOut = 'Sign Out';

  static const String appBy = 'App by Antoine Ho, 2020';
  static const String newExpense = 'New Expense';
  static const String newIncome = 'New Income';
  static const String total = 'Total';
  static const String name = 'Name';
  static const String price = 'Price';
  static const String value = 'Value';
  static const String amount = 'Amount';
  static const String icons = 'Icons';
  static const String noData = 'No expenses to show in the statistics page!';
  static const String confirm = 'Confirm';
  static const String incomes = 'Incomes';
  static const String expenses = 'Expenses';
  static const String stats = 'Stats';
  static const String categories = 'Categories';
  static const String about = 'About';
  static const String balance = 'Balance';
  static const String color = 'Color';

  // * QUESTIONS
  static const String confirmMsg = 'Are you sure you want to delete?';

  static const String confirmDeleteCategory =
      'Deleting this category will subsequently delete all items of this type. Are you sure you want to delete?';

  // * INSTRUCTIONS
  static const String pickADate = 'Pick a date';
  static const String pickAMonth = 'Pick a month';
  static const String addAnExpense = 'Add an expense!';
  static const String signInToAvoidLosingData =
      'Sign In to avoid losing your data!';
  static const String pickAColor = 'Pick a color';

  // * EXPENSE categories
  static const String expense = 'Expense';
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
  static const String income = 'Income';
  static const String salary = 'Salary';
  static const String gift = 'Gift';
  static const String business = 'Business';
  static const String insurance = 'Insurance';
  static const String realEstate = 'Real Estate';
  static const String investment = 'Investment';
  static const String refund = 'Refund';
  static const String otherIncomes = 'Other Incomes';

  // * DRAWER options
  static const String monthly = 'Monthly';
  static const String yearly = 'Yearly';

  // * ERROR messages
  static const String cantBeEmpty = 'can\'t be empty';
  static const String isInvalid = 'is invalid';

  // * SNACKBAR messages
  static const String succAdded = 'Successfully added';
  static const String succEdited = 'Successfully edited';
  static const String succDeleted = 'Successfully deleted';

  // * ITEM DATABASE table and column names
  static const String dbFileName = 'itemsDb.db';
  static const String tableItems = 'items';
  static const String itemColumnId = 'expense_id'; // TODO: rename to item id
  static const String itemColumnName = 'name';
  static const String itemColumnValue = 'value';
  static const String itemColumnDate = 'date';
  static const String itemColumnCategory = 'category';
  static const String itemColumnType =
      'type'; // TODO: DEPRECATED. use categories type

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
