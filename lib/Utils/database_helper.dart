import 'dart:io';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
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
    await db.execute('''
              CREATE TABLE ${Strings.tableExpenses} (
                ${Strings.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.columnName} TEXT NOT NULL,
                ${Strings.columnPrice} DOUBLE NOT NULL,
                ${Strings.columnDate} TEXT NOT NULL,
                ${Strings.columnCategory} INTEGER NOT NULL
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
          Strings.columnDate,
          Strings.columnCategory
        ],
        where: '${Strings.columnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Expense.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Expense>> queryExpensesInDate(DateTime date) async {
    Database db = await database;
    String dateStrToFind = date.toIso8601String().split('T')[0];
    print(dateStrToFind);

    List<Map> maps = await db.query(Strings.tableExpenses, where: '${Strings.columnDate} LIKE \'$dateStrToFind%\'');

    List<Expense> expenses = new List();
    if (maps.length > 0) {
      for (Map row in maps) {
        print('Added');
        expenses.add(new Expense.fromMap(row));
      }
    }

    return expenses;
  }

  Future<List<Expense>> queryAllExpenses() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableExpenses);

    List<Expense> expenses = new List();
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

  Future<int> delete(int id) async {
    Database db = await database;

    return await db.delete(Strings.tableExpenses,
        where: '${Strings.columnId} = ?', whereArgs: [id]);
  }

  //Future close() async => db.close();

  // void customQuery() async {
  //   Database db = await database;

  //   db.rawQuery('DROP TABLE ${Strings.tableExpenses}');

  //   await db.execute('''
  //             CREATE TABLE ${Strings.tableExpenses} (
  //               ${Strings.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
  //               ${Strings.columnName} TEXT NOT NULL,
  //               ${Strings.columnPrice} DOUBLE NOT NULL,
  //               ${Strings.columnDate} TEXT NOT NULL,
  //               ${Strings.columnCategory} INTEGER NOT NULL
  //             )
  //             ''');
  // }
}
