import 'dart:io';
import 'package:Expenseye/Models/Expense.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static const _databaseName = "ExpensesDb.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 4;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print('creating expenses table');
    await db.execute('''
              CREATE TABLE ${Strings.tableExpenses} (
                ${Strings.expenseColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.expenseColumnName} TEXT NOT NULL,
                ${Strings.expenseColumnPrice} DOUBLE NOT NULL,
                ${Strings.expenseColumnDate} TEXT NOT NULL,
                ${Strings.expenseColumnCategory} INTEGER NOT NULL
              )
              ''');

    print('creating incomes table');
    await db.execute('''
              CREATE TABLE ${Strings.tableIncomes} (
                ${Strings.incomeColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.incomeColumnName} TEXT NOT NULL,
                ${Strings.incomeColumnAmount} DOUBLE NOT NULL,
                ${Strings.incomeColumnDate} TEXT NOT NULL,
                ${Strings.incomeColumnCategory} INTEGER NOT NULL
              )
              ''');
  }

  Future<int> insertExpense(Expense expense) async {
    Database db = await database;
    int id = await db.insert(Strings.tableExpenses, expense.toMap());
    return id;
  }

  Future<Expense> queryExpense(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(Strings.tableExpenses,
        columns: [
          Strings.expenseColumnId,
          Strings.expenseColumnName,
          Strings.expenseColumnPrice,
          Strings.expenseColumnDate,
          Strings.expenseColumnCategory
        ],
        where: '${Strings.expenseColumnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Expense.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Expense>> queryExpensesInDate(DateTime date) async {
    Database db = await database;
    String dateStrToFind = date.toIso8601String().split('T')[0];

    List<Map> maps = await db.query(Strings.tableExpenses,
        where: '${Strings.expenseColumnDate} LIKE \'$dateStrToFind%\'');

    return convertMapsToExpenses(maps);
  }

  Future<List<Expense>> queryExpensesInMonth(String yearMonth) async {
    Database db = await database;

    List<Map> maps = await db.query(
      Strings.tableExpenses,
      where: '${Strings.expenseColumnDate} LIKE \'$yearMonth%\'',
      orderBy: '${Strings.expenseColumnDate} DESC',
    );

    return convertMapsToExpenses(maps);
  }

  Future<List<Expense>> queryExpensesInYear(String year) async {
    Database db = await database;

    List<Map> maps = await db.query(
      Strings.tableExpenses,
      where: '${Strings.expenseColumnDate} LIKE \'$year%\'',
      orderBy: '${Strings.expenseColumnDate} DESC',
    );

    return convertMapsToExpenses(maps);
  }

  Future<List<Expense>> queryAllExpenses() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableExpenses);

    return convertMapsToExpenses(maps);
  }

  Future<int> updateExpense(Expense expense) async {
    Database db = await database;

    return await db.update(Strings.tableExpenses, expense.toMap(),
        where: '${Strings.expenseColumnId} = ?', whereArgs: [expense.id]);
  }

  Future<int> deleteExpense(int id) async {
    Database db = await database;

    return await db.delete(Strings.tableExpenses,
        where: '${Strings.expenseColumnId} = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM ${Strings.tableExpenses}');
  }

  List<Expense> convertMapsToExpenses(List<Map> maps) {
    List<Expense> expenses = new List();
    if (maps.length > 0) {
      for (Map row in maps) {
        expenses.add(new Expense.fromMap(row));
      }
    }

    return expenses;
  }
}
