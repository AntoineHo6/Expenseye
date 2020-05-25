class Strings {
  static const String versionNumber = '1.3.0';

  // * EXPENSE categories EN
  static const String foodEN = 'Food';
  static const String transportationEN = 'Transport';
  static const String shoppingEN = 'Shopping';
  static const String entertainmentEN = 'Entertainment';
  static const String activityEN = 'Activity';
  static const String medicalEN = 'Medical';
  static const String homeEN = 'Home';
  static const String travelEN = 'Travel';
  static const String peopleEN = 'People';
  static const String educationEN = 'Education';
  static const String otherExpensesEN = 'Other Expenses';
  // * EXPENSE categories FR
  static const String foodFR = 'Nourriture';
  static const String transportationFR = 'Transportation';
  static const String shoppingFR = 'Magazinage';
  static const String entertainmentFR = 'Divertissement';
  static const String activityFR = 'Activité';
  static const String medicalFR = 'Médical';
  static const String homeFR = 'Domicile';
  static const String travelFR = 'Voyage';
  static const String peopleFR = 'Gens'; 
  static const String educationFR = 'Éducation';
  static const String otherExpensesFR = 'Autres Dépenses';

  // * INCOME categories EN
  static const String salaryEN = 'Salary';
  static const String giftEN = 'Gift';
  static const String businessEN = 'Business';
  static const String insuranceEN = 'Insurance';
  static const String realEstateEN = 'Real Estate';
  static const String investmentEN = 'Investment';
  static const String refundEN = 'Refund';
  static const String otherIncomesEN = 'Other Incomes';
  // * INCOME categories FR
  static const String salaryFR = 'Salaire';
  static const String giftFR = 'Cadeau';
  static const String businessFR = 'Affaire';
  static const String insuranceFR = 'Assurance';
  static const String realEstateFR = 'Immobilier';
  static const String investmentFR = 'Investissement';
  static const String refundFR = 'Remboursement';
  static const String otherIncomesFR = 'Autres Revenus';

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
