import 'dart:io';
import 'package:expense_app_beginner/Models/Expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'Resources/Strings.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 3;

  final String tableExpenses = Strings.tableExpenses;
  final String columnId = Strings.columnId;
  final String columnName = Strings.columnName;
  final String columnPrice = Strings.columnPrice;
  final String columnDate = Strings.columnDate;

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

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableExpenses (
                $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
                $columnName TEXT NOT NULL,
                $columnPrice DOUBLE NOT NULL,
                $columnDate TEXT NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(Expense expense) async {
    Database db = await database;
    int id = await db.insert(tableExpenses, expense.toMap());
    return id;
  }

  Future<Expense> queryExpense(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableExpenses,
        columns: [columnId, columnName, columnPrice, columnDate],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Expense.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Expense>> queryAllExpenses() async {
    Database db = await database;

    List<Expense> expenses = new List();

    List<Map> maps = await db.rawQuery('SELECT * FROM $tableExpenses');

    if (maps.length > 0) {
      for (Map row in maps) {
        expenses.add(new Expense.fromMap(row));
      }
    }

    return expenses;
  }

  void deleteAllData() async {
    Database db = await database;

    await db.execute('''
              CREATE TABLE $tableExpenses (
                $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
                $columnName TEXT NOT NULL,
                $columnPrice DOUBLE NOT NULL,
                $columnDate TEXT NOT NULL
              )
              ''');
  }

  // TODO: delete(int id)
  // TODO: update(Word word)
}
