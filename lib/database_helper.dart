import 'dart:io';
import 'package:expense_app/Models/Expense.dart';
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
    await db.execute('''
              CREATE TABLE ${Strings.tableExpenses} (
                ${Strings.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.columnName} TEXT NOT NULL,
                ${Strings.columnPrice} DOUBLE NOT NULL,
                ${Strings.columnDate} TEXT NOT NULL
              )
              ''');
  }

  Future<int> insert(Expense expense) async {
    Database db = await database;
    int id = await db.insert(Strings.tableExpenses, expense.toMap());
    return id;
  }

  Future<Expense> queryExpense(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(Strings.tableExpenses,
        columns: [
          Strings.columnId,
          Strings.columnName,
          Strings.columnPrice,
          Strings.columnDate
        ],
        where: '${Strings.columnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Expense.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Expense>> queryAllExpenses() async {
    Database db = await database;

    List<Expense> expenses = new List();

    List<Map> maps = await db.query('${Strings.tableExpenses}');

    if (maps.length > 0) {
      for (Map row in maps) {
        expenses.add(new Expense.fromMap(row));
      }
    }

    return expenses;
  }

  Future<int> update(Expense expense) async {
    Database db = await database;

    return await db.update(Strings.tableExpenses, expense.toMap(),
        where: '${Strings.columnId} = ?', whereArgs: [expense.id]);
  }

  // void deleteAllData() async {
  //   Database db = await database;

  // }

  // TODO: delete(int id)
}
