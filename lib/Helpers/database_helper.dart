import 'dart:io';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/default_categories.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static const _databaseName = Strings.dbFileName;
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 6;

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
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    print('creating items table');
    await db.execute('''
              CREATE TABLE ${Strings.tableItems} (
                ${Strings.itemColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.itemColumnName} TEXT NOT NULL,
                ${Strings.itemColumnValue} DOUBLE NOT NULL,
                ${Strings.itemColumnDate} TEXT NOT NULL,
                ${Strings.itemColumnCategory} TEXT NOT NULL,
                ${Strings.itemColumnType} INTEGER NOT NULL
              )
              ''');

    print('Creating categories table');
    await db.execute('''
          CREATE TABLE ${Strings.tableCategories} (
            ${Strings.categoryColumnId} TEXT PRIMARY KEY,
            ${Strings.categoryColumnName} TEXT NOT NULL,
            ${Strings.categoryColumnIconCodePoint} TEXT NOT NULL,
            ${Strings.categoryColumnColor} TEXT NOT NULL,
            ${Strings.categoryColumnType} INTEGER NOT NULL
          )
          ''');

    await _insertDefaultCategories(db);

    print('Creating reccurrent expenses table');
    await db.execute('''
            CREATE TABLE ${Strings.tableRecurrentItems} (
              ${Strings.recurrentItemColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${Strings.recurrentItemColumnName} TEXT NOT NULL,
              ${Strings.recurrentItemColumnValue} DOUBLE NOT NULL,
              ${Strings.recurrentItemColumnDay} INTEGER NOT NULL,
              ${Strings.recurrentItemColumnIsAdded} INTEGER NOT NULL,
              ${Strings.recurrentItemColumnCategory} TEXT NOT NULL,
              FOREIGN KEY(${Strings.recurrentItemColumnCategory}) REFERENCES ${Strings.tableCategories}(${Strings.categoryColumnId})
            )
            ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<int> insertItem(Item expense) async {
    Database db = await database;
    int id = await db.insert(Strings.tableItems, expense.toMap());
    return id;
  }

  Future<Item> queryItem(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(Strings.tableItems,
        columns: [
          Strings.itemColumnId,
          Strings.itemColumnName,
          Strings.itemColumnValue,
          Strings.itemColumnDate,
          Strings.itemColumnCategory,
          Strings.itemColumnType
        ],
        where: '${Strings.itemColumnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Item.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Item>> queryItemsInDate(DateTime date) async {
    Database db = await database;
    String dateStrToFind = date.toIso8601String().split('T')[0];

    List<Map> maps = await db.query(Strings.tableItems,
        where: '${Strings.itemColumnDate} LIKE \'$dateStrToFind%\'');

    return convertMapsToItems(maps);
  }

  Future<List<Item>> queryItemsByMonth(String yearMonth) async {
    Database db = await database;

    List<Map> maps = await db.query(
      Strings.tableItems,
      where: '${Strings.itemColumnDate} LIKE \'$yearMonth%\'',
      orderBy: '${Strings.itemColumnDate} DESC',
    );

    return convertMapsToItems(maps);
  }

  Future<List<Item>> queryItemsInYear(String year) async {
    Database db = await database;

    List<Map> maps = await db.query(
      Strings.tableItems,
      where: '${Strings.itemColumnDate} LIKE \'$year%\'',
      orderBy: '${Strings.itemColumnDate} DESC',
    );

    return convertMapsToItems(maps);
  }

  Future<List<Item>> queryAllItems() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableItems);

    return convertMapsToItems(maps);
  }

  Future<int> updateItem(Item item) async {
    Database db = await database;

    return await db.update(Strings.tableItems, item.toMap(),
        where: '${Strings.itemColumnId} = ?', whereArgs: [item.id]);
  }

  Future<int> deleteItem(int id) async {
    Database db = await database;

    return await db.delete(Strings.tableItems,
        where: '${Strings.itemColumnId} = ?', whereArgs: [id]);
  }

  Future<int> deleteItemsByCategory(String categoryId) async {
    Database db = await database;

    return await db.delete(Strings.tableItems,
        where: '${Strings.itemColumnCategory} = ?', whereArgs: [categoryId]);
  }

  Future<void> deleteAllItems() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM ${Strings.tableItems}');
    await db.rawQuery('DELETE FROM ${Strings.tableRecurrentItems}');
  }

  List<Item> convertMapsToItems(List<Map> maps) {
    List<Item> items = new List();
    if (maps.length > 0) {
      for (Map row in maps) {
        items.add(new Item.fromMap(row));
      }
    }

    return items;
  }

  Future<void> _insertDefaultCategories(Database db) async {
    for (var category in DefaultCategories.categories) {
      await db.insert(Strings.tableCategories, category.toMap());
    }
  }

  Future<void> insertDefaultCategories() async {
    Database db = await database;
    for (var category in DefaultCategories.categories) {
      await db.insert(Strings.tableCategories, category.toMap());
    }
  }

  Future<List<Category>> queryCategories() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableCategories);

    return convertMapsToCategories(maps);
  }

  List<Category> convertMapsToCategories(List<Map> maps) {
    List<Category> categories = new List();
    if (maps.length > 0) {
      for (Map row in maps) {
        categories.add(new Category.fromMap(row));
      }
    }

    return categories;
  }

  Future<void> insertCategory(Category category) async {
    Database db = await database;

    await db.insert(Strings.tableCategories, category.toMap());
  }

  Future<void> deleteCategory(String id) async {
    Database db = await database;

    return await db.delete(Strings.tableCategories,
        where: '${Strings.categoryColumnId} = ?', whereArgs: [id]);
  }

  Future<void> deleteAllCategories() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM ${Strings.tableCategories}');
  }
}
